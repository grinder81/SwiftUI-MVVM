//
//  APIRequest.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-11-15.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation

protocol APIRequestType {
    associatedtype Response: Codable
    associatedtype Query
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var cacheKey: String { get }
}
