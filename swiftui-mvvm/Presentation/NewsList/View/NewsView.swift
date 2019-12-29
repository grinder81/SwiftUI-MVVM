//
//  ContentView.swift
//  swiftui-mvvm
//
//  Created by MD AL MAMUN (LCL) on 2019-12-22.
//  Copyright © 2019 MD AL MAMUN. All rights reserved.
//

import SwiftUI
import Combine

struct NewsView: View {
    @EnvironmentObject private var viewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.articles, id:\.id) { (article) in
                NavigationLink(destination: Text("\(article.description ?? "")")) {
                    Text("\(article.description ?? "")")
                }
            }.navigationBarTitle("Top Headlines")
        }.onAppear {
            self.viewModel.onAppear = ()
        }
    }
}

struct NewsViewModifier: ViewModifier {
    let viewModel: NewsViewModel
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }
    
    func body(content: Content) -> some View {
        content
            .environmentObject(viewModel)
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .modifier(NewsViewModifier(viewModel: NewsViewModel()))
    }
}

