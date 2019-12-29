//
//  DataService.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-28.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation
import Combine

protocol DataService {
    func save<Model>(model: Model, by key: String) where Model: Codable
    func read<Model>(type: Model.Type, for key: String) -> Model? where Model: Codable
    
    //func observe<Model, Request>(for request: Request) -> AnyPublisher<Model, Never> where Model: Codable, Request: DataRequest
}
