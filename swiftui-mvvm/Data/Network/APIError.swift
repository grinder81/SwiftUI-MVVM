//
//  APIError.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-26.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation

struct APIError: Swift.Error {
    let status: String?
    let code: String?
    let message: String?
    let error: Error?
}

extension APIError: Decodable {
    private enum CodingKeys: String, CodingKey {
        case status
        case code
        case message
    }
    
    init(error: Error) {
        self.error   = error
        self.status  = nil
        self.code    = nil
        self.message = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status  = try container.decode(String.self, forKey: .status)
        self.code    = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
        self.error   = nil
    }
}

extension APIError {
    static func makeError(from data: Data) -> Error {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(APIError.self, from: data)
        } catch {
            return error
        }
    }
    
    static func makeInvalidUrlError() -> Error {
        return NSError(domain: "Invalid Url error", code: 0, userInfo: nil)
    }
}
