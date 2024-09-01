//
//  MakeUserProfile.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-20.
//

import SwiftUI
import UIKit
import FirebaseFirestore
import FirebaseStorage


struct MakeUserProfile: View {
    
    @State var completeProfile: Bool = false
    @State var isImagePicker: Bool = false
    @State var selectedImage: UIImage?
    @State var name: String = ""
    @State var bio: String = ""
    @AppStorage("uId") var userID: String = ""
    @AppStorage("madeProfile") var madeProfile: Bool = false
    @ObservedObject var model = ViewModel()
    @State var documentAdded:Bool = false
    
    var body: some View {
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
                    
                    NavigationStack{
                        HStack{
                            NavigationLink("Skip"){
                                Home()
                            }.foregroundColor(.black)
                                .navigationTitle("Edit Profile")
                            Spacer()
                            
                            Button(action: {
                                if (model.usersList.first(where: {$0.userID == userID}) == nil){
                                    uploadProfile()
                                }
                                
                                if documentAdded{
                                    madeProfile = true
                                    print("Profile updated")
                                }
                            }, label: {
                                Text("Done")
                            }).padding()
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(17)
                        }.padding()
                    }.navigationDestination(isPresented: $madeProfile){
                        Home()
                    }
                }
            }.padding()
        }
    }
    
    func uploadProfile() {
        guard selectedImage != nil else {
            return
        }
        
        
        let storageReference = Storage.storage().reference()
        
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let fileRef = storageReference.child("UserProfileImages/\(name).jpg")
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                // Image upload successful, now upload name and bio to Firestore
                let db = Firestore.firestore()
                
                db.collection("User").addDocument(data: [
                    "userID":self.userID,
                    "name": self.name,
                    "bio": self.bio,
                    "imageURL": fileRef.fullPath // Store the path to the uploaded image
                ]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                        
                    } else {
                        documentAdded = true
                        print("Document successfully added!")
                    }
                }
            } else {
                print("Error uploading image: \(String(describing: error))")
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
