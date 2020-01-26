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
protocol NewsDIUseCaseFactory {
    func makeFetchTopHeadlineQueriesUseCase() -> FetchTopHeadlineQueriesUseCase
}

// MARK: - Repositories protocol
protocol NewsDIRepositoryFactory {
    func makeTopHeadlineRepositories() -> TopHeadlineRepository
}

// MARK: - Vews protocol
// FIXME: Returning concret type. You can't use ObservedObject or Observale in non-class type
protocol NewsDIViewsFactory {
    func makeNewsView() -> AnyView
    func makeNewsViewModifier() -> NewsViewModifier
}

typealias NewsDIContainerType = NewsDIUseCaseFactory & NewsDIRepositoryFactory & NewsDIViewsFactory


final class NewsDIContainer: NewsDIContainerType {
    
    let dataService: DataService
    let appConfig: ApplicationConfigurationType
    
    init(dataService: DataService, appConfig: ApplicationConfigurationType) {
        self.dataService = dataService
        self.appConfig   = appConfig
    }
    
    // MARK: - UseCases
    func makeFetchTopHeadlineQueriesUseCase() -> FetchTopHeadlineQueriesUseCase {
        return DefaultFetchTopHeadlineQueriesUseCase(headlineRepo: self.makeTopHeadlineRepositories())
    }
    
    // MARK: - Repositories
    func makeTopHeadlineRepositories() -> TopHeadlineRepository {
        return DefaultTopHeadlineRepository(url: appConfig.envConfigurator.baseUrl,
                                            dataService: dataService,
                                            urlSession: appConfig.urlSession)
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

