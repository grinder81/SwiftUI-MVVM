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
    
    @State private var showToast: Bool = false
    
    var body: some View {
        NavigationView {
            List(self.viewModel.articles, id:\.id) { (article) in
                NavigationLink(destination: Text("\(article.description ?? "")")) {
                    Text("\(article.description ?? "")")
                }
            }
            .navigationBarTitle("Top Headlines")
            .navigationBarItems(trailing: Button(action: {
                withAnimation {
                    self.showToast.toggle()
                }
            }){
                Text("Toggle toast")
            })
        }.onAppear {
            self.viewModel.onAppear = ()
        }.toast(isShowing: $showToast, text: Text("Hello toast!"))
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

