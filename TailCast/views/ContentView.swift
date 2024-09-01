//
//  ContentView.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("uId") var userID: String = ""
    @AppStorage("madeProfile") var madeProfile: Bool = false
    
    var body: some View {
        
        if userID == ""{
            Authview()
        }else{
            if madeProfile{
                Home()
            }else{
                MakeUserProfile()
            }
        }
    }
}

#Preview {
    ContentView()
}
