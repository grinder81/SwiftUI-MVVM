//
//  NewsStore.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2020-01-17.
//  Copyright © 2020 MD AL MAMUN. All rights reserved.
//

import Foundation
import Combine

final class NewsStore: ObservableObject {
    @Published private(set) var articles: [Article] = []
}
