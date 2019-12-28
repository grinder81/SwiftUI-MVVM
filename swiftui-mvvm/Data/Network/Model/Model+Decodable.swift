//
//  Model+Decodable.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-25.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation

extension Source: Decodable {
    
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
    
}

extension Article: Decodable {
    
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
    
}
