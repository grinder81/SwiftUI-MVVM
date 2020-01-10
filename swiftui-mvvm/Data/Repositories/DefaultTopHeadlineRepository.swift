//
//  DefaultTopHeadlineRepository.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-25.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Combine
import Foundation

final class DefaultTopHeadlineRepository: APIServiceType {
    
    private let baseUrl: URL
    private let urlSession: URLSession
    private let dataService: DataService
    
    init(url: URL = URL(string: "https://newsapi.org")!,
         dataService: DataService = UserDefaultStorage.shared,
         urlSession: URLSession = .shared) {
        self.dataService = dataService
        self.baseUrl     = url
        self.urlSession  = urlSession
    }

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, Error> where Request : APIRequestType {
        
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
            // DEBUG: activate that line to see cache and API response
            .delay(for: 5, scheduler: DispatchQueue.global())
            .subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
    
}

// This is `D` of the SOLID
// and it's called dependency inversion
// We are using repository from domain layer
// and any use case call this real implementation
// without knowing what exactly the implementation
// In clean archiecture that's the inward dependency 

extension DefaultTopHeadlineRepository: TopHeadlineRepository {
    func headlineList(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage, Error> {
        let request = TopHeadlineAPIRequest(query: query)
        
        // Make API call and then write to cache but cache won't trigger the
        // change because we will only accept cache data once in a session
        let apiSignal = self.response(from: request)
            .map { ArticlePage(totalResults: $0.articles.count, articles: $0.articles)}
            .handleEvents(receiveOutput: { (response) in
                self.dataService.save(model: response, by: request.cacheKey)
            })
            .eraseToAnyPublisher()
        
        // This is just once executing
        let cacheSignal = self.dataService
            .observeOnce(type: ArticlePage.self, for: request.cacheKey)
            .replaceNil(with: .init(totalResults: 0, articles: []))
            .eraseToAnyPublisher()
        
        return Publishers.Merge(apiSignal, cacheSignal)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}
