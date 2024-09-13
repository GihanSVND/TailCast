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
                    
                    Image("sign_back")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .offset(y: 315)
                        .ignoresSafeArea()
                    
                }
                
                VStack(spacing: 15){
                    
                    Text("Create an Account!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(0.0)
                        .offset(y: -65)
                    
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
                            if(password.count != 0){
                                Text(password.isValidPssword(password) ? "Strong" : "Weak")
                                    .fontWeight(.bold)
                                    .foregroundColor(password.isValidPssword(password) ? .green : .red)
                            }
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
                            
                            SecureField("", text: $checkPassword)
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .placeholder(when: checkPassword.isEmpty){
                                    Text("Confirm Password")
                                        .foregroundColor(.black)
                                        
                                }
                                .background(Color.white)
                                
                            Spacer()
                            Text(password != checkPassword && checkPassword != "" ? "Incorrect" : "")
                                .fontWeight(.bold)
                                .foregroundColor(password != checkPassword && checkPassword != "" ? .red : .green)
                            
                        }.padding()
                            .background(Color.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.black,lineWidth: 3)
                        }
                    }
                    
                    
                    
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
                        ZStack{
                            RoundedRectangle(cornerRadius: 7)
                                .frame(height: 60)
                                .foregroundColor(.black)
                                .offset(x:7,y:5)
                            
                            Text("Register")
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
                    
                    
                    Button{
                        withAnimation(Animation.easeOut){
                            self.currentView = "login"
                        }
                    } label: {
                        Text("Already have an account? Login")
                            .foregroundColor(.black)
                            .bold()
                        
                    }.offset(y:50)
                    
                }
                .padding()
                .offset(y:-55)
            }
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
