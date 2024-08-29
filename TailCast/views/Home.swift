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

struct Home: View {
    @ObservedObject var model = ViewModel()
    @State var profileImage: UIImage?
    
    
    let index: Int = 1
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                    
                    VStack{
                        
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
                    }
                }.padding()
                    .navigationTitle("Home")
                    .navigationBarBackButtonHidden(true)
                    .toolbar{
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            
                            if let user = model.usersList.first{
                                HStack{
                                    if let image = profileImage{
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 40,height: 40)
                                            .cornerRadius(50)
                                                                                }else {
                                        ProgressView()
                                            .onAppear {
                                                user.loadImage { img in
                                                    self.profileImage = img
                                                }
                                            }
                                    }
                                }
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




#Preview {
    Home()
}
