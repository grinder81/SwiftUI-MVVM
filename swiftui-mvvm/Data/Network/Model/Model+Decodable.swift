//
//  Model+Decodable.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-25.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation

extension Source: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url
        case category
        case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id             = try? container.decode(String.self, forKey: .id)
        self.name           = try? container.decode(String.self, forKey: .name)
        self.description    = try? container.decode(String.self, forKey: .description)
        self.url            = try? container.decode(URL.self, forKey: .url)
        self.category       = try? container.decode(String.self, forKey: .category)
        self.country        = try? container.decode(String.self, forKey: .country)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.country, forKey: .country)
    }
}

extension Article: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        self.source      = try container.decode(Source.self, forKey: .source)
        self.author      = try? container.decode(String.self, forKey: .author)
        self.title       = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.url         = try? container.decode(URL.self, forKey: .url)
        self.urlToImage  = try? container.decode(URL.self, forKey: .urlToImage)
        self.publishedAt = try? container.decode(Date.self, forKey: .publishedAt)
        self.content     = try? container.decode(String.self, forKey: .content)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.source, forKey: .source)
        try container.encode(self.author, forKey: .author)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.urlToImage, forKey: .urlToImage)
        try container.encode(self.publishedAt, forKey: .publishedAt)
        try container.encode(self.content, forKey: .content)
    }
}
