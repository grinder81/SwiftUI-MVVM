//
//  EnvironmentConfig.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2020-01-05.
//  Copyright © 2020 MD AL MAMUN. All rights reserved.
//

import Foundation

// Add everything that's depend on your app environement
// 1. PROD
// 2. UAT
// 2. DEV etc
protocol EnvironmentConfigType {
    var baseUrl: URL { get }
    var apiKey: String { get }
}

final class DefaultEnvironmentConfig: Codable {
    let url: URL
    let key: String
}

extension DefaultEnvironmentConfig: EnvironmentConfigType {
    var baseUrl: URL {
        return url
    }
    
    var apiKey: String {
        return key
    }
}

extension DefaultEnvironmentConfig {
    static func makeConfig(from bundle: Bundle, file name: String) -> EnvironmentConfigType {
        return bundle.decode(DefaultEnvironmentConfig.self, from: name)
    }
}
