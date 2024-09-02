//
//  Home.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth

struct Home: View {
    @ObservedObject var model = ViewModel()
    @State var profileImage: UIImage?
    @AppStorage("uId") var userID: String = ""
    
    let index: Int = 1
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading){
                        Text("Top Authors")
                        Spacer()
                            .frame(height: 10.0)
                        if model.authorsList.indices.contains(index) {
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                Image("Author01")
                                                    .resizable()
                                                    .frame(width: 100.0, height: 100.0)
                                                    .cornerRadius(23)
                                                Text(model.authorsList[0].Name)
                                            }
                                        }.padding()
                                    }
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                Image("Author01")
                                                    .resizable()
                                                    .frame(width: 100.0, height: 100.0)
                                                    .cornerRadius(23)
                                                Text(model.authorsList[1].Name)
                                            }
                                        }.padding()
                                    }
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                Image("Author01")
                                                    .resizable()
                                                    .frame(width: 100.0, height: 100.0)
                                                    .cornerRadius(23)
                                                Text(model.authorsList[2].Name)
                                            }
                                        }.padding()
                                    }
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                Image("Author01")
                                                    .resizable()
                                                    .frame(width: 100.0, height: 100.0)
                                                    .cornerRadius(23)
                                                Text(model.authorsList[3].Name)
                                            }
                                        }.padding()
                                    }
                                }.font(.caption)
                                    .foregroundColor(.black)
                                
                                
                            }
                            
                        }
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

                        Spacer()
                        HStack{
                            BookCard()
                                .padding(.top, 25.0)
                            Spacer()
                            BookCard()
                                .padding(.top, 25.0)
                                .offset(y:30)
                        }
                        HStack{
                            BookCard()
                                .padding(.top, 25.0)
                            Spacer()
                            BookCard()
                                .padding(.top, 25.0)
                                .offset(y:30)
                        }
                        
                    }
                    
                    
                }.padding()
                    .navigationTitle("Home")
                    .navigationBarBackButtonHidden(true)
                    .toolbar{
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            
                            if let user = model.usersList.first(where: {$0.userID == userID}){
                                HStack{
                                    if let image = profileImage{

                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 40,height: 40)
                                            .cornerRadius(50)
                                    }else {
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .frame(width: 40,height: 40)
                                            .cornerRadius(50)
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
                                    .frame(width: 40,height: 40)
                                    .cornerRadius(50)
                            }
                        }
                    }
                
            }
        }
    }
    init(){
        model.getAuthorData()
        model.getUserData()
        
    }
}

struct BookCard: View {
    
//    var bookTitle: String
//    var author: String
//    var bookCover: UIImage
    
    var body: some View {
        VStack {
            Image("Wolf of SIGHT")
                .resizable()
                .frame(width:147, height: 207.6)
                .cornerRadius(17)
            HStack {
                Text("Wolf of SIGHT")
                    .font(.subheadline)
                .fontWeight(.bold)
                Spacer()
            }.padding(.leading)
            HStack {
                Text("by Trif Premade")
                    .font(.footnote)
                Spacer()
            }.padding(.leading)
            
            
        }
        
    }
}

#Preview {
    Home()
}
