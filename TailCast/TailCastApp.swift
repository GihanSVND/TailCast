//
//  TailCastApp.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import SwiftUI
import Firebase

@main
struct TailCastApp: App {
    init() {
        
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MakeUserProfile()
        }
    }
}
