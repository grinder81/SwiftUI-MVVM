//
//  DefaultTopHeadlineRepository.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-25.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Combine
import Foundation

final class DefaultTopHeadlineRepository: APIService {
    
    private let baseUrl: URL
    private let urlSession: URLSession
    private let dataService: DataService
    
    init(dataService: DataService = UserDefaultStorage.shared,
         url: String = "https://newsapi.org",
         urlSession: URLSession = .shared) {
        self.dataService = dataService
        self.baseUrl     = URL(string: url)!
        self.urlSession  = urlSession
    }

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, Error> where Request : APIRequest {
        
        // Path + Component
        guard let pathUrl = URL(string: request.path, relativeTo: baseUrl) else {
            return Fail(error: APIError.makeInvalidUrlError())
                    .eraseToAnyPublisher()
        }
        
        var urlComponents = URLComponents(url: pathUrl, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        
        // Request
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data, response) in
                guard let response = response as? HTTPURLResponse,
                    200..<300 ~= response.statusCode else {
                        throw APIError.makeError(from: data)
                }
                return data
            })
            .decode(type: Request.Response.self, decoder: decoder)
            .mapError { APIError(error: $0) }
            .delay(for: 5, scheduler: DispatchQueue.global())
            .subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
    
}

// TODO: - will need to adjust for caching layer
extension DefaultTopHeadlineRepository: TopHeadlineRepository {
    func headlineList(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage?, Error> {
        let request = TopHeadlineAPIRequest(query: query)
        
        // FIXME: that must need to using Combine async and not blocking main thread
        // Also it should be Merge of cache layer and API
        let cacheData = self.dataService.read(type: ArticlePage.self, for: request.identifiableKey)
        return self.response(from: request)
            .map { ArticlePage(totalResults: $0.articles.count, articles: $0.articles)}
            .handleEvents(receiveOutput: { (response) in
                // FIXME: Create operator 
                self.dataService.save(model: response, by: request.identifiableKey)
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .prepend(cacheData)
            .eraseToAnyPublisher()
    }

}
