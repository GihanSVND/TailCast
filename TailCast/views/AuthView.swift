//
//  AuthView.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-31.
//
import SwiftUI

struct Authview: View {
    @State private var currentView: String = "login"
    
    var body: some View {
        
        if(currentView == "login"){
            Login(currentView: $currentView)
        }else{
            Signup(currentView: $currentView)
        }
    }
}

#Preview {
    Authview()
}
