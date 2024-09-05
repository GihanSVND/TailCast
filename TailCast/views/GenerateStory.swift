//
//  GenerateStory.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-02.
//

import SwiftUI
import GoogleGenerativeAI
import AVFoundation

struct GenerateStory: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIkey.default)
    @State var textInput = ""
    @State var fantacy:Bool = false
    @State var thriller:Bool = false
    @State var dramatic:Bool = false
    @State var style = "normal"
    @State var wordCount = "500"
    @State var aiResponce = "Create your own story"
    @State var generateStory:Bool = false
    
    var body: some View {
        
        ZStack {
            Image("GenStoryArt")
                .resizable()
                .frame(height: 540)
                .offset(y:-200)
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    GroupBox{
                        Text(aiResponce)
                    }.padding()
                    Spacer()
                }
            }
            Button(action: {
                generateStory = true
            }, label: {
                Text("Generate Story")
            })
            .sheet(isPresented: $generateStory, onDismiss: nil, content: {
                VStack {
                    HStack {
                        Text("Enter the word Count")
                        Spacer()
                        TextField("Count" , text: $wordCount)
                            .padding()
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.trailing)
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 3))
                    }
                    
                    Spacer()
                        .frame(height: 35.0)
                    HStack{
                        Text("Story Style")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    HStack{
                        Toggle(isOn: $fantacy, label: {
                            Text("Fantacy")
                        }).toggleStyle(.button)
                            .onChange(of: fantacy){
                                if fantacy == true{
                                    thriller = false
                                    dramatic = false
                                }
                            }
                        
                        Toggle(isOn: $thriller, label: {
                            Text("Thriller")
                        }).toggleStyle(.button)
                            .onChange(of: thriller){
                                if thriller == true{
                                    fantacy = false
                                    dramatic = false
                                }
                            }
                        
                        Toggle(isOn: $dramatic, label: {
                            Text("Dramatic")
                        }).toggleStyle(.button)
                            .onChange(of: dramatic){
                                if dramatic == true{
                                    fantacy = false
                                    thriller = false
                                }
                            }
                        
                        
                    }.accentColor(.black)
                    HStack{
                        TextField("Enter the message", text: $textInput)
                        Button(action: {
                            sendMessage()
                            generateStory = false
                        }, label: {
                            Image(systemName: "paperplane.fill")
                        })
                    }.padding()
                }.padding()
            })
            
        }
    }
    
    func sendMessage() {
        aiResponce = ""
        Task{
            do{
                if fantacy == true{
                    style = "fantacy"
                }
                
                if thriller == true{
                    style = "thriller"
                }
                
                if dramatic == true{
                    style = "dramatic"
                }
                
                let response = try await model.generateContent("think as a creative stiry teller and writer with 20 years of experience. generate a creative and joyfull story on \"" + textInput + "\"your story shoud have simple but beautifull word manner and easy to understand. your story should be less than" + wordCount + "words. The theme of the complete story should be" + style)
                
                guard let text = response.text else {
                    textInput = "Couldn't process the task"
                    return
                }
                textInput = ""
                aiResponce = text
            } catch{
                aiResponce = "sSomthing went wrong \n \(error.localizedDescription)"
            }
        }
    }
}


#Preview {
    GenerateStory()
}
