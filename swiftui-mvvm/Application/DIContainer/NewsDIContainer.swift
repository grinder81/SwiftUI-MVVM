//
//  NewsDIContainer.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-26.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - UseCase protocol
protocol NewsDIUseCaseType {
    func makeFetchTopHeadlineQueriesUseCase() -> FetchTopHeadlineQueriesUseCase
}

// MARK: - Repositories protocol
protocol NewsDIRepositoryType {
    func makeTopHeadlineRepositories() -> TopHeadlineRepository
}

// MARK: - Vews protocol
// FIXME: Returning concret type. You can't use ObservedObject or Observale in non-class type
protocol NewsDIViewsType {
    func makeNewsView() -> AnyView
    func makeNewsViewModifier() -> NewsViewModifier
}

typealias NewsDIContainerType = NewsDIUseCaseType & NewsDIRepositoryType & NewsDIViewsType


final class NewsDIContainer: NewsDIContainerType {
    // MARK: - UseCases
    func makeFetchTopHeadlineQueriesUseCase() -> FetchTopHeadlineQueriesUseCase {
        return DefaultFetchTopHeadlineQueriesUseCase(headlineRepo: self.makeTopHeadlineRepositories())
    }
    
    // MARK: - Repositories
    func makeTopHeadlineRepositories() -> TopHeadlineRepository {
        return DefaultTopHeadlineRepository()
    }
    
    // MARK: - NewsView
    func makeNewsViewModifier() -> NewsViewModifier {
        return NewsViewModifier(viewModel: makeNewsViewModel())
    }
    
    func makeNewsView() -> AnyView {
        return NewsView()
            .modifier(makeNewsViewModifier())
            .eraseToAnyView()
    }

    private func makeNewsViewModel() -> NewsViewModel {
        return NewsViewModel(fetchUseCase: makeFetchTopHeadlineQueriesUseCase())
    }
    
}

