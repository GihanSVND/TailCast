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
                Image("CLAWS")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
                    .offset(y: 25)
                Image("loging_back")
                    .resizable()
                    .frame(width: 350, height: 350)
                    .offset(y: 135)
                    .ignoresSafeArea()
                    
            }
            
            
            VStack(spacing:30){
                
                Text("WELCOME AGAIN!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(0.0)
                    
                    
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
                    
                    
                
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 2))
                
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
                    Text("Login")
                        .padding()
                        .padding(.horizontal, 125.0)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }.offset(y:40)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Login Error"), message: Text("Invalid Username or Password"), dismissButton: .default(Text("OK")))
                    }
                
                
                Button{
                    withAnimation(Animation.bouncy){
                        self.currentView = "signup"
                    }
                } label: {
                    Text("Don't have an account? Register")
                        .foregroundColor(.black)
                        .bold()
                        
                }.offset(y:50)
                
            }
            .padding()
        }
        
        
    }
}

extension String{
    
    func isValidEmail() -> Bool{
        
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)

        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
        
    }
    
}

extension String{
    
    func isValidPssword(_ password: String) -> Bool{
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)

        
    }
    
}


