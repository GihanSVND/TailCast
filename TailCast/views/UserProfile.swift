//
//  UserProfile.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-07.
//

import SwiftUI
import FirebaseAuth


struct UserProfile: View {
    @AppStorage("uId") var userID: String = ""
    var body: some View {
        
        NavigationStack{
            VStack{
                Button {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        withAnimation {
                            withAnimation {
                                userID = ""
                            }
                        }
                        
                        
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                } label: {
                    Text("Logout")
                }
                NavigationLink(destination: MakeUserProfile()){
                    Text("Edit User Profile")
                }
            }.navigationTitle("Profile")
        }
    }
}

#Preview {
    UserProfile()
}
