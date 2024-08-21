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
    var body: some View {
        NavigationView{
            NavigationStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.white)
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        if(selectedImage != nil){
                            
                            Image(uiImage: selectedImage!)
                                .frame(width: 200,height: 200)
                                .cornerRadius(120)
                            
                        }else{
                            Image(systemName: "circle.fill")
                                
                                .resizable()
                                .frame(width: 200,height: 200)
                                .foregroundColor(.black.opacity(0.2))
                        }
                        Spacer()
                            .frame(height: 24.0)
                        
                        
                        
                        Button(action: {
                            //upload image
                            isImagePicker = true
                        }, label: {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 43,height: 35)
                        }).offset(y:-137)
                        .sheet(isPresented: $isImagePicker, onDismiss: nil, content: {
                            ImagePicker(selecteImage: $selectedImage, isPickerShowing: $isImagePicker)
                        })
                        Spacer()
                            .frame(height: 30)
                        
                        TextField("", text: $name)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(23)
                            .textFieldStyle(.plain)
                            .placeholder(when: name.isEmpty){
                                Text("Enter Your name")
                                    .padding()
                                    .foregroundColor(.black)
                                    
                            }
                        
                        Spacer()
                        
                    }.padding()
                    
                }
            }.navigationTitle("Profile")
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
