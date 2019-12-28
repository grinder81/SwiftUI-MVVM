//
//  Source.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-24.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import Foundation

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
