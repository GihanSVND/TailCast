//
//  Login.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-31.
//
import SwiftUI
import FirebaseAuth

struct Login: View {
    
    @Binding var currentView: String
    
    @State private var email: String = ""
    @State private var password: String = ""
    @AppStorage("uId") var userID: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        
        ZStack{
            Color(.white)
                .ignoresSafeArea()
            
            VStack(spacing: 300){
                Image("loging_back")
                    .resizable()
                    .frame(width: 280, height: 280)
                    .offset(x:65,y: 345)
                    .ignoresSafeArea()
                    
            }
            
            
            VStack(spacing:30){
                
                Text("WELCOME AGAIN!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(0.0)
                    .offset(y:-40)
                    
                
                ZStack{
                    RoundedRectangle(cornerRadius: 7)
                        .frame(height: 60)
                        .foregroundColor(.black)
                        .offset(x:5,y:5)
                    
                    HStack{
                        Image(systemName: "person.fill")
                        
                        TextField("", text: $email)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: email.isEmpty){
                                Text("Email")
                                    .foregroundColor(.black)
                                    
                            }
                            .background(Color.white)
                            
                        Spacer()
                    }.padding()
                        .background(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.black,lineWidth: 3)
                    }
                        
                    
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 7)
                        .frame(height: 60)
                        .foregroundColor(.black)
                        .offset(x:5,y:5)
                    
                    HStack{
                        Image(systemName: "lock.fill")
                        
                        SecureField("", text: $password)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: password.isEmpty){
                                Text("Password")
                                    .foregroundColor(.black)
                                    
                            }
                            .background(Color.white)
                            
                        Spacer()
                    }.padding()
                        .background(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.black,lineWidth: 3)
                    }
                        
                    
                }
                
                
                Button{
                    
                    Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                        
                        if let error = error{
                            
                            showAlert = true
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult{
                            print(authResult.user.uid)
                            withAnimation {
                                userID = authResult.user.uid
                            }
                            
                        }
                        
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 7)
                            .frame(height: 60)
                            .foregroundColor(.black)
                            .offset(x:7,y:5)
                        
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(7)
                            .overlay {
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.white,lineWidth: 3)
                            }
                    }
                }.offset(y:40)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Login Error"), message: Text("Invalid Username or Password"), dismissButton: .default(Text("OK")))
                    }
                
                
                Button{
                    withAnimation(Animation.easeOut){
                        self.currentView = "signup"
                    }
                } label: {
                    Text("Don't have an account? Register")
                        .foregroundColor(.black)
                        .bold()
                        
                }.offset(y:50)
                
            }
            .padding()
            .offset(y:-70)
        }
        
        
    }
}

