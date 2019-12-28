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
    
    init(url: String = "https://newsapi.org") {
        baseUrl = URL(string: url)!
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
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data, response) in
                guard let response = response as? HTTPURLResponse,
                    200..<300 ~= response.statusCode else {
                        throw APIError.makeError(from: data)
                }
                return data
            })
            .decode(type: Request.Response.self, decoder: decoder)
            .mapError { APIError(error: $0) }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

// TODO: - will need to adjust for caching layer
extension DefaultTopHeadlineRepository: TopHeadlineRepository {
    func headlineList(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage, Error> {
        let request = TopHeadlineAPIRequest(query: query)
        return self.response(from: request)
            .map { ArticlePage(totalResults: $0.articles.count, articles: $0.articles)}
            .eraseToAnyPublisher()
    }

}
