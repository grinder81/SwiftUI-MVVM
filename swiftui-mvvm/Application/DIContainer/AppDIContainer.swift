//
//  AppDIContainer.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-26.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Define all sub-container 
protocol AppDIContainerType {
    var newsDIContainer: NewsDIContainerType { get }
}

final class AppDIContainer: AppDIContainerType {
    
    lazy var newsDIContainer: NewsDIContainerType = {
        return NewsDIContainer()
    }()
    
}

// MARK: - EnvironmentKey exposure
struct AppDIContainerKey: EnvironmentKey {
    static var defaultValue: AppDIContainerType {
        return AppDIContainer()
    }
}

// MARK: - Environment Values exposure
extension EnvironmentValues {
    var appDiContainer: AppDIContainerType {
        get {
            return self[AppDIContainerKey.self]
        }
        set {
            self[AppDIContainerKey.self] = newValue
        }
    }
}
