//
//  NewsTopHeadlineAPIResuqest.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-25.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation

struct TopHeadlineAPIRequest: APIRequestType {
    typealias Response = TopHeadlineResponse
    typealias Query    = TopHeadlineQuery
    
    let query: Query
    
    init(query: Query) {
        self.query = query
    }
    
    var path: String { return "/v2/top-headlines" }
    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        // FIXME: - apiKey need to handle through env 
        items.append(.init(name: "apiKey", value: "1944816ba04b445c9264dbb74f4e5b32"))
        items.append(contentsOf: query.queryItems)
        return items
    }
    
    var cacheKey: String {
        return self.query.key
    }
}

extension TopHeadlineQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        items.append(.init(name: "country", value: self.country))
        if let category = self.category {
            items.append(.init(name: "category", value: category))
        }
        if let pageSize = self.pageSize {
            items.append(.init(name: "pageSize", value: String(pageSize)))
        }
        if let page = self.page {
            items.append(.init(name: "page", value: String(page)))
        }
        
        return items
    }
    
    var key: String {
        return country + (category ?? "")
    }
}

struct TopHeadlineResponse: Codable, Hashable {
    var articles: [Article]
}
