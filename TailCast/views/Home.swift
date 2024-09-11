//
//  Home.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth

struct Home: View {
    @ObservedObject var model = ViewModel()
    @State var profileImage: UIImage?
    @State var authorImage0: UIImage?
    @State var authorImage1: UIImage?
    @State var authorImage2: UIImage?
    @State var authorImage3: UIImage?
    @State var bookCover0: UIImage?
    @State var bookCover1: UIImage?
    @State var bookCover2: UIImage?
    @State var bookCover3: UIImage?
    @AppStorage("uId") var userID: String = ""
    
    let index: Int = 1
    
    @State var selectedView = 0
    var body: some View {
        NavigationStack{
            Divider()
            ScrollView{
                
                ZStack{
                    
                    VStack(alignment: .leading){
                        
                        Text("Top Authors")
                        
                        Spacer()
                            .frame(height: 5.0)
                        if model.authorsList.indices.contains(index) {
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                
                                                let author = model.authorsList[0]
                                                
                                                if let image = authorImage0{
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                    
                                                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                                                    
                                                    Text(author.Name)
                                                        .padding(.top, 5.0)
                                                    
                                                }else{
                                                    ProgressView()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                        .onAppear{
                                                            author.loadAuthorImage{img in
                                                                self.authorImage0 = img
                                                                
                                                            }
                                                        }
                                                    Text(author.Name)
                                                }
                                            }
                                            
                                        }.padding()
                                    }
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                
                                                let author = model.authorsList[1]
                                                
                                                if let image = authorImage1{
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                    
                                                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                                                    
                                                    Text(author.Name)
                                                        .padding(.top, 5.0)
                                                    
                                                }else{
                                                    ProgressView()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                        .onAppear{
                                                            author.loadAuthorImage{img in
                                                                self.authorImage1 = img
                                                                
                                                            }
                                                        }
                                                    Text(author.Name)
                                                }
                                            }
                                            
                                        }.padding()
                                    }
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                
                                                let author = model.authorsList[2]
                                                
                                                if let image = authorImage2{
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                    
                                                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                                                    
                                                    Text(author.Name)
                                                        .padding(.top, 5.0)
                                                    
                                                }else{
                                                    ProgressView()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                        .onAppear{
                                                            author.loadAuthorImage{img in
                                                                self.authorImage2 = img
                                                                
                                                            }
                                                        }
                                                    Text(author.Name)
                                                }
                                            }
                                            
                                        }.padding()
                                    }
                                    
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack {
                                                
                                                let author = model.authorsList[3]
                                                
                                                
                                                if let image = authorImage3{
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                    
                                                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                                                    
                                                    Text(author.Name)
                                                        .padding(.top, 5.0)
                                                    
                                                }else{
                                                    ProgressView()
                                                        .frame(width: 100.0, height: 100.0)
                                                        .cornerRadius(7)
                                                        .onAppear{
                                                            author.loadAuthorImage{img in
                                                                self.authorImage3 = img
                                                                
                                                            }
                                                        }
                                                    Text(author.Name)
                                                }
                                            }
                                            
                                        }.padding()
                                    }
                                }
                                
                            }.font(.caption)
                                .foregroundColor(.black)
                            
                            Divider()
                            Spacer()
                                .frame(height: 35.0)
                            VStack{
                                HStack{
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack(alignment:.leading) {
                                                let book = model.bookList[0]
                                                if let image = bookCover0{
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 157, height: 207)
                                                        .cornerRadius(7)
                                                    
                                                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                                                    
                                                    Text(book.Name)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.headline)
                                                        .foregroundColor(Color.black)
                                                        .padding(.top, 5.0)
                                                    Text(book.Author)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.footnote)
                                                        .foregroundColor(Color.black)
                                                    
                                                    
                                                    
                                                }else{
                                                    ProgressView()
                                                        .frame(width: 157, height: 207)
                                                        .cornerRadius(7)
                                                        .onAppear{
                                                            book.loadBookCover{img in
                                                                self.bookCover0 = img
                                                            }
                                                        }
                                                    Text(book.Name)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.headline)
                                                        .foregroundColor(Color.black)
                                                        .padding(.top, 5.0)
                                                    Text(book.Author)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.footnote)
                                                        .foregroundColor(Color.black)
                                                }
                                            }
                                        }.padding()
                                    }.frame(width:160, height: 215)
                                        
                                    Spacer()
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack(alignment:.leading) {
                                                let book = model.bookList[1]
                                                if let image = bookCover1{
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 157, height: 207)
                                                        .cornerRadius(7)
                                                    
                                                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                                                    
                                                    Text(book.Name)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.headline)
                                                        .foregroundColor(Color.black)
                                                        .padding(.top, 5.0)
                                                    Text(book.Author)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.footnote)
                                                        .foregroundColor(Color.black)
                                                    
                                                    
                                                }else{
                                                    ProgressView()
                                                        .frame(width: 157, height: 207)
                                                        .cornerRadius(7)
                                                        .onAppear{
                                                            book.loadBookCover{img in
                                                                self.bookCover1 = img
                                                            }
                                                        }
                                                    Text(book.Name)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.headline)
                                                        .foregroundColor(Color.black)
                                                        .padding(.top, 5.0)
                                                    Text(book.Author)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.footnote)
                                                        .foregroundColor(Color.black)
                                                }
                                            }
                                        }.padding()
                                    }.frame(width:160, height: 215)
                                        .offset(y:25)
                                    
                                }
                                Spacer()
                                    .frame(height: 65.0)
                                HStack{
                                    VStack {
                                        Button {
                                            //go some where
                                        } label: {
                                            VStack(alignment:.leading) {
                                                let book = model.bookList[2]
                                                if let image = bookCover2{
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 157, height: 207)
                                                        .cornerRadius(7)
                                                    
                                                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                                                    
                                                    Text(book.Name)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.headline)
                                                        .foregroundColor(Color.black)
                                                        .padding(.top, 5.0)
                                                    Text(book.Author)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.footnote)
                                                        .foregroundColor(Color.black)
                                                    
                                                    
                                                }else{
                                                    ProgressView()
                                                        .frame(width: 157, height: 207)
                                                        .cornerRadius(7)
                                                        .onAppear{
                                                            book.loadBookCover{img in
                                                                self.bookCover2 = img
                                                            }
                                                        }
                                                    Text(book.Name)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.headline)
                                                        .foregroundColor(Color.black)
                                                        .padding(.top, 5.0)
                                                    Text(book.Author)
                                                        .frame(width: 160)
                                                        .lineLimit(nil)
                                                        .font(.footnote)
                                                        .foregroundColor(Color.black)
                                                }
                                            }
                                        }.padding()
                                    }.frame(width:160, height: 215)
                                        
                                    Spacer()
                                    
                                    
                                }
                            }.padding()
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                
            }.padding()
                .navigationTitle("Home")
                .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink(destination: UserProfile()){
                            HStack{
                                if let user = model.usersList.first(where: {$0.userID == userID}){
                                    HStack{
                                        if let image = profileImage{
                                            Image(uiImage: image)
                                                .resizable()
                                                .frame(width: 40,height: 40)
                                                .cornerRadius(50)
                                        }else {
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .frame(width: 40,height: 40)
                                                .cornerRadius(50)
                                                .onAppear {
                                                    user.loadImage { img in
                                                        self.profileImage = img
                                                    }
                                                }
                                        }
                                    }
                                }else{
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 40,height: 40)
                                        .cornerRadius(50)
                                }
                            }
                        }
                        Spacer()
                        
                        
                    }
                }
            
            
        }
    }
    
    
    init(){
        model.getAuthorData()
        model.getUserData()
        model.getBookData()
        
    }
}

struct BookCard: View {
    
    var bookTitle: String
    var author: String
    var bookCover: UIImage
    
    var body: some View {
        
        VStack {
            Image(uiImage: bookCover)
                .resizable()
                .frame(width:147, height: 207.6)
                .cornerRadius(17)
            HStack {
                Text(bookTitle)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
            }.padding(.leading)
            HStack {
                Text(author)
                    .font(.footnote)
                Spacer()
            }.padding(.leading)
            
            
        }
        
    }
}

#Preview {
    Home()
}
