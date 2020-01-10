//
//  View+Extenstion.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-28.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              text: text)
    }

}
