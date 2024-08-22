//
//  MakeUserProfile.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-20.
//

import SwiftUI
import UIKit

struct MakeUserProfile: View {
    
    @State var isImagePicker: Bool = false
    @State var selectedImage: UIImage?
    @State var name: String = ""
    @State var bio: String = ""
    var body: some View {
        NavigationView{
            NavigationStack{
                ZStack{
                    
                    VStack {
                        Spacer()
                            .frame(height: 20)
                        if(selectedImage != nil){
                            
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(width: 200,height: 200)
                                .cornerRadius(120)
                                .overlay(RoundedRectangle(cornerRadius: 150)
                                    .stroke(lineWidth: 3)
                                    .frame(width: 220,height: 220))
                            
                        }else{
                            Image("ProfilePic")
                                .resizable()
                                .frame(width: 200,height: 200)
                                .foregroundColor(.black.opacity(0.2))
                                .cornerRadius(150)
                                .overlay(RoundedRectangle(cornerRadius: 150)
                                    .stroke(lineWidth: 3)
                                    .frame(width: 220,height: 220))
                        }
                        Spacer()
                            .frame(height: 24.0)
                        
                        
                        
                        Button(action: {
                            //upload image
                            isImagePicker = true
                        }, label: {
                            Text("Edit")
                                .foregroundColor(.black)
                        })
                        .sheet(isPresented: $isImagePicker, onDismiss: nil, content: {
                            ImagePicker(selecteImage: $selectedImage, isPickerShowing: $isImagePicker)
                        })
                        Spacer()
                            .frame(height: 30)
                        
                        TextField("", text: $name)
                            .padding()
                            .foregroundColor(.white)
                            .placeholder(when: name.isEmpty){
                                Text("Enter Your name")
                                    .padding()
                                    .foregroundColor(.white)
                            }
                            .background(Color.black)
                            .cornerRadius(23)
                            .textFieldStyle(.plain)
                        
                        Spacer()
                            .frame(height: 30.0)
                        TextField("", text: $bio)
                            .padding()
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .cornerRadius(23)
                            .textFieldStyle(.plain)
                            .placeholder(when: bio.isEmpty){
                                Text("Tell Us About You...")
                                    .padding()
                                    .foregroundColor(.black)
                            }.overlay(RoundedRectangle(cornerRadius: 23)
                                .stroke(lineWidth: 2))
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                //go somewhere
                            }, label: {
                                Text("Skip")
                                    .foregroundColor(.black)
                            })
                            Spacer()
                            
                            Button(action: {
                                //go somewhere
                            }, label: {
                                
                                Text("Done")
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(17)
                            })
                        }.padding()
                    }
                }.padding()
            }.navigationTitle("Edit Profile")
        }
    }
    
}
extension View{
    func placeholder<Content : View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View{
            
            ZStack (alignment: alignment){
                placeholder().opacity(shouldShow ? 1:0)
                self
            }
        }
}

#Preview {
    MakeUserProfile()
}
