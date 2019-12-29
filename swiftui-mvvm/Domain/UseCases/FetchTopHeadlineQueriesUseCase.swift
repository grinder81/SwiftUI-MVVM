//
//  FetchTopHeadlineQueriesUseCase.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-25.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Combine

// UseCase will use Repository to:
// 1. Get data from API or
// 2. Get data from cache
// 3. Repository isolate or abstract source of the response

protocol FetchTopHeadlineQueriesUseCase {
    func execute(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage?, Error>
}

final class DefaultFetchTopHeadlineQueriesUseCase: FetchTopHeadlineQueriesUseCase {
    
    let topHeadlineRepository: TopHeadlineRepository
    
    init(headlineRepo: TopHeadlineRepository) {
        self.topHeadlineRepository = headlineRepo
    }
    
    // We can do more here like:
    // Error handling for only this use case
    // Mapping data to something or more 
    func execute(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage?, Error> {
        return self.topHeadlineRepository.headlineList(for: query)
    }
    
}
