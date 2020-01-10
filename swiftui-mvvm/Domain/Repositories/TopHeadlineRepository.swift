//
//  TopHeadlineRepository.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-24.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Combine

// This is `L` of SOLID principal which is Liskove Principal
// We should be able to use use this Type inplace of
// Real implementation one which make substitute clean 
protocol TopHeadlineRepository {
    func headlineList(for query: TopHeadlineQuery) -> AnyPublisher<ArticlePage, Error>
}
