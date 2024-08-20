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
                        .foregroundColor(Color(hue: 0.761, saturation: 0.981, brightness: 0.133))
                        .ignoresSafeArea()
                    
                    VStack {
                        if(selectedImage != nil){
                            
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(width: 200,height: 200)
                                .cornerRadius(120)
                            
                        }else{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 200,height: 200)
                                .foregroundColor(.purple)
                        }
                        Spacer()
                            .frame(height: 24.0)
                        Button(action: {
                            //upload image
                            isImagePicker = true
                        }, label: {
                            HStack {
                                
                                Text("Upload Image")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Image(systemName: "square.and.arrow.up")
                                    .offset(y:-5)
                                    .font(.title3)
                                    .foregroundColor(.purple)
                            }
                        })
                        .sheet(isPresented: $isImagePicker, onDismiss: nil, content: {
                            ImagePicker(selecteImage: $selectedImage, isPickerShowing: $isImagePicker)
                        })
                        Spacer()
                            .frame(height: 30)
                        
                        TextField("", text: $name)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.purple.opacity(0.3))
                            .cornerRadius(23)
                            .textFieldStyle(.plain)
                            .placeholder(when: name.isEmpty){
                                Text("Enter Your name")
                                    .padding()
                                    .foregroundColor(.purple)
                                    .bold()
                            }
                        
                        Spacer()
                        
                    }.padding()
                    
                }
            }
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
