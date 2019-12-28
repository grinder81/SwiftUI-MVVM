//
//  LaunchView.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-27.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import SwiftUI

struct LaunchView: View {
    
    @Environment(\.appDiContainer) private var appDiContainer
    
    var body: some View {
        appDiContainer.newsDIContainer.makeNewsView()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environment(\.appDiContainer, AppDIContainerKey.defaultValue)
    }
}
