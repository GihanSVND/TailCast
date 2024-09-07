//
//  testing.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-31.
//

import SwiftUI

struct tabView: View {
    @State var selectedView = 2
    var body: some View {
        TabView(selection: $selectedView){
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(0)
            GenerateStory()
                .tabItem {
                    Image(systemName: "book")
                    Text("Generate Story")
                }.tag(1)
        }
    }
}

#Preview {
    tabView()
}
