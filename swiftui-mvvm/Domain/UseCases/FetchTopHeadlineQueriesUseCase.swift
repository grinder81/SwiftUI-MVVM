//
//  FetchTopHeadlineQueriesUseCase.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-25.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Combine

// This `S` of SOLID principal
// Every class should have single responsiblity and a UseCase does
// solve one just one case. This way we won't put massive class
// of functionality

// This is also `I` of SOLID principal which is
// Interface segregation princial
// In short: we shouldn't have a gaint protocol
// where we define everything and client's need in many casee.
// That come the rule of composition. Instead of a gaint
// protocol A we can seperate A1, A2, A3 and then client
// can confrim as they need
protocol FetchTopHeadlineQueriesUseCase {
    func execute(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage, Error>
}


// UseCase will use Repository as dependency to:
// 1. Get data from API or
// 2. Get data from cache
// 3. Repository isolate or abstract source of the response


final class DefaultFetchTopHeadlineQueriesUseCase: FetchTopHeadlineQueriesUseCase {
    
    let topHeadlineRepository: TopHeadlineRepository
    
    init(headlineRepo: TopHeadlineRepository) {
        self.topHeadlineRepository = headlineRepo
    }
    
    // We can do more here like:
    // Error handling for only this use case
    // Mapping data to something or more 
    func execute(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage, Error> {
        return self.topHeadlineRepository.headlineList(for: query)
    }
    
}
