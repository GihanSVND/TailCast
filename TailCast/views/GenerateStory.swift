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
    @State var quantity: Double = 100
    @State var wordCount = "500"
    @State var aiResponce = "Create your own story"
    @State var generateStory:Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                
                ScrollView{
                    VStack{
                        GroupBox{
                            Text(aiResponce)
                        }
                        .padding()
                            
                        Spacer()
                    }
                }
                .frame(height: 520)
                .offset(y:-80)
                
                Button(action: {
                    generateStory = true
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 7)
                            .frame(height: 60)
                            .foregroundColor(.black)
                            .offset(x:7,y:5)
                        
                        Text("New Story")
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
                }).padding(.horizontal, 20)
                    .offset(y:210)
                    .sheet(isPresented: $generateStory, onDismiss: nil, content: {
                        VStack {
                            HStack{
                                Text("Word Count")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(String(format: "%.0f", quantity))")
                                    .padding()
                            }
                            Slider(value: $quantity,in: 100...500,step:1)
                            Divider()
                            HStack{
                                Text("Story Style")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                VStack{
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
                                    
                                    
                                }
                            }
                            Divider()
                            HStack{
                                TextField("Enter the message", text: $textInput)
                                Button(action: {
                                    sendMessage()
                                    generateStory = false
                                }, label: {
                                    Image(systemName: "paperplane.fill")
                                })
                            }.padding()
                        }.padding() .presentationDetents([.fraction(0.5)])
                    })
                
            }.navigationTitle("Shorts")
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
                wordCount = String(format: "%.0f", quantity)
                
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
