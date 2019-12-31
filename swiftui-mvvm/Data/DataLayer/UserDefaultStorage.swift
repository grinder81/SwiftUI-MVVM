//
//  UserDefaultStorage.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-28.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation
import Combine

final class UserDefaultStorage: DataService {
    
    private var userDefaults: UserDefaults

    init(suite: String) {
        let combined = UserDefaults.standard
        combined.addSuite(named: suite)
        self.userDefaults = combined
    }
    
    func save<Model>(model: Model, by key: String) where Model : Codable {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            userDefaults.set(encoded, forKey: key)
        }
    }
    
    func read<Model>(type: Model.Type, for key: String) -> Model? where Model : Codable {
        if let data = userDefaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(type, from: data) {
                return model
            }
        }
        return nil
    }
    
    func observeOnce<Model>(type: Model.Type, for key: String) -> AnyPublisher<Model?, Error> where Model: Codable {
        return Future<Model?, Error> { promise in
            promise(.success(self.read(type: type, for: key)))
        }.eraseToAnyPublisher()
    }
        
}

extension UserDefaultStorage {
    
    static var shared: UserDefaultStorage {
        return UserDefaultStorage(suite: "com.swift-mvvm.storgae")
    }
    
}
