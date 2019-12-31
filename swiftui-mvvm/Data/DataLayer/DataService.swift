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
    
    // This is just generating publisher to execute read async
    // to do real observe, we need KVO with data source 
    func observeOnce<Model>(type: Model.Type, for key: String) -> AnyPublisher<Model?, Error> where Model: Codable
}
