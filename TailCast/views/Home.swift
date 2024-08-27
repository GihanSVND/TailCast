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
    
    
    let index: Int = 1
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                    VStack{
                        if model.list.indices.contains(index) {
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
                                                Text(model.list[0].Name)
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
                                                Text(model.list[1].Name)
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
                                                Text(model.list[2].Name)
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
                                                Text(model.list[3].Name)
                                            }
                                        }.padding()
                                    }
                                }.font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }.padding()
            }
        }.navigationTitle("Home")
            .navigationBarBackButtonHidden(true)
    }
    init(){
        model.getData()
    }
}

#Preview {
    Home()
}
