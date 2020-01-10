//
//  ApplicationConfigurations.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2020-01-05.
//  Copyright © 2020 MD AL MAMUN. All rights reserved.
//

import Foundation


protocol ApplicationConfigurationType {
    var envConfigurator: EnvironmentConfigType { get }
    var urlSession: URLSession { get }
}

final class DefaultApplicationConfigurations: ApplicationConfigurationType {
    
    lazy var urlSession: URLSession = {
        // You can do any kind of configuration etc
        // Even you can variation of url session
        // Like one for image another for API etc
        return URLSession.shared
    }()
    
    
    lazy var envConfigurator: EnvironmentConfigType = {
        return DefaultEnvironmentConfig.makeConfig(from: Bundle.main, file: "envConfig.json")
    }()
    
}
