//
//  TopHeadlineQuery.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-24.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation

struct TopHeadlineQuery {
    let country: String
    let category: String?
    let pageSize: Int?
    let page: Int?
    
    init(country: String, category: String? = nil, pageSize: Int? = nil, page: Int? = nil) {
        self.country = country
        self.category = category
        self.pageSize = pageSize
        self.page = page
    }
}
