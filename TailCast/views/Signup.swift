//
//  Signup.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-31.
//
import SwiftUI
import FirebaseAuth

struct Signup: View {
    
    @Binding var currentView: String
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var checkPassword: String = ""
    @AppStorage("uId") var userID: String = ""
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color(.white)
                    .ignoresSafeArea()
                
                VStack(spacing: 300){
                    Image("CLAWS")
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                        .offset(y: 25)
                    Image("sign_back")
                        .resizable()
                        .frame(width: 350, height: 350)
                        .offset(y: 164)
                        .ignoresSafeArea()
                    
                }
                
                VStack(spacing: 15){
                    
                    Text("Create an Account!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(0.0)
                        .offset(y: -15)
                    
                    
                    HStack{
                        Image(systemName: "person.fill")
                        
                        TextField("", text: $email)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: email.isEmpty){
                                Text("Email")
                                    .foregroundColor(.black)
                                    .bold()
                            }
                        Spacer()
                        
                        
                    }.padding()
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 2))
                    
                    
                    HStack{
                        Image(systemName: "lock.fill")
                        
                        SecureField("", text: $password)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: password.isEmpty){
                                Text("Password")
                                    .foregroundColor(.black)
                                    .bold()
                            }
                        Spacer()
                        if(password.count != 0){
                            Text(password.isValidPssword(password) ? "Strong" : "Weak")
                                .fontWeight(.bold)
                                .foregroundColor(password.isValidPssword(password) ? .green : .red)
                        }
                        
                        
                    }.padding()
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 2))
                    
                    HStack{
                        Image(systemName: "lock.fill")
                        
                        SecureField("", text: $checkPassword)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: checkPassword.isEmpty){
                                Text("Confirm Password")
                                    .foregroundColor(.black)
                                    .bold()
                            }
                        Spacer()
                        Text(password != checkPassword && checkPassword != "" ? "Incorrect" : "")
                            .fontWeight(.bold)
                            .foregroundColor(password != checkPassword && checkPassword != "" ? .red : .green)
                    }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2))
                    Button{
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            if let error = error{
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
                        Text("Register")
                            
                            .padding()
                            .padding(.horizontal, 125.0)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }.offset(y:40)
                    
                    
                    Button{
                        withAnimation(Animation.bouncy){
                            self.currentView = "login"
                        }
                    } label: {
                        Text("Already have an account? Login")
                            .foregroundColor(.black)
                            .bold()
                        
                    }.offset(y:50)
                    
                }
                .padding()
            }
        }
    }
}
