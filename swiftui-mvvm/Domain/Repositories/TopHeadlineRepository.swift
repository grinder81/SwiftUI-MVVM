//
//  TopHeadlineRepository.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-24.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Combine

protocol TopHeadlineRepository {
    func headlineList(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage?, Error>
}
