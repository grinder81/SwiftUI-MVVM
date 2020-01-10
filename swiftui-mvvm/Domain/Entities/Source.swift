//
//  Source.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-24.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation


// This is `O` of SOLID principal
// Entities should be closed for motification
// which is done by let but open for extension
// which we can do by `extension`
struct Source: Identifiable {
    let id: String?
    let name: String?
    let description: String?
    let url: URL?
    let category: String?
    let country: String?
}

extension Source: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
