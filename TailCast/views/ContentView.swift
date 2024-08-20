//
//  ContentView.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModel()
    var body: some View {
        ZStack {
            List(model.list) {item in
                Text(item.Name)
                
            }
        }
    }
    init(){
        model.getData()
    }
}

#Preview {
    ContentView()
}
