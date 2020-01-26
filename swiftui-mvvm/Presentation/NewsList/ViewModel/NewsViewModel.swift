//
//  RootViewModel.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-22.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Combine
import SwiftUI

final class NewsViewModel: ObservableObject {

    // MARK: - Input
    @Published var countryDidChange: String = "us"
    @Published var onAppear: Void = ()
    
    // MARK: - Output
    @Published private(set) var articles: [Article] = []

    // MARK: - local
    private var disposeBag = Set<AnyCancellable>()
    
    private let fetchTopHeadlineQueryUseCase: FetchTopHeadlineQueriesUseCase

    init(fetchUseCase: FetchTopHeadlineQueriesUseCase = DefaultFetchTopHeadlineQueriesUseCase(
        headlineRepo: DefaultTopHeadlineRepository())) {
        self.fetchTopHeadlineQueryUseCase = fetchUseCase
        bindOutputs()
    }
    
    private func bindOutputs() {
        Publishers.CombineLatest($countryDidChange, $onAppear.dropFirst())
            .map { $0.0 }
            .flatMap { [fetchTopHeadlineQueryUseCase] country -> AnyPublisher<ArticlePage, Never> in
                return fetchTopHeadlineQueryUseCase.execute(for: TopHeadlineQuery(country: country))
                    .replaceError(with: .init(totalResults: 0, articles: []))
                    .eraseToAnyPublisher()
            }
            .map { $0.articles }
            .assign(to: \.articles, on: self)
            .store(in: &disposeBag)
    }
    
}
