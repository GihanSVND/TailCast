//
//  UserProfile.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-07.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth

struct UserProfile: View {
    @AppStorage("uId") var userID: String = ""
    @ObservedObject var model = ViewModel()
    @State private var showLogoutDialog = false
    @State var profileImage: UIImage?
    
    var body: some View {
        
        NavigationStack{
            VStack{
                ZStack{
                    if let user = model.usersList.first(where: {$0.userID == userID}){
                        HStack{
                            if let image = profileImage{
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 200,height: 200)
                                    .cornerRadius(100)
                                    .overlay(RoundedRectangle(cornerRadius: 150)
                                        .stroke(lineWidth: 3)
                                        .frame(width: 220,height: 220))
                            }else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 200,height: 200)
                                    .cornerRadius(100)
                                    .onAppear {
                                        user.loadImage { img in
                                            self.profileImage = img
                                        }
                                    }
                            }
                        }
                    }else{
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 200,height: 200)
                            .cornerRadius(100)
                    }
                    
                    
                }.offset(y:-120)
                if let user = model.usersList.first(where: {$0.userID == userID}){
                    VStack{
                        Text(user.Name)
                            .font(.title)
                            .fontWeight(.bold)
                            .offset(y:-120)
                        Text(user.Bio)
                            .offset(y:-120)
                            
                    }
                }
                
                Button {
                    showLogoutDialog = true
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 7)
                            .frame(height: 60)
                            .foregroundColor(.black)
                            .offset(x:7,y:5)
                        
                        Text("Log Out")
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(7)
                            .overlay {
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.white,lineWidth: 3)
                            }
                    }
                }.confirmationDialog("Are you sure you want to log out?", isPresented: $showLogoutDialog, titleVisibility: .visible) {
                    Button("Log Out", role: .destructive) {
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
                    }
                    Button("Cancel", role: .cancel) { }
                }
                
            }.navigationTitle("Profile")
                .padding()
                .toolbar{
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink(destination: MakeUserProfile()){
                            Text("Edit")
                        }
                    }
                }
        }
    }
    
    init(){
        model.getUserData()
    }
}

#Preview {
    UserProfile()
}
