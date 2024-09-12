//
//  Library.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-11.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth

struct Library: View {
    
    @ObservedObject var model = ViewModel()
    @State var bookCover0: UIImage?
    @State var bookCover1: UIImage?
    @State var bookCover2: UIImage?
    @State var bookCover3: UIImage?
    @AppStorage("uId") var userID: String = ""
    let index: Int = 1
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment:.leading){
                    Divider()
                    Text("Favourits")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                        .frame(height: 40.0)
                    HStack{
                        if model.bookList.indices.contains(index) {
                            VStack {
                                Button {
                                    //go some where
                                } label: {
                                    VStack(alignment:.leading) {
                                        let book = model.bookList[0]
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
                        }
                    }
                    Spacer()
                        .frame(height: 50.0)
                    Divider()
                    Text("Favourits")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                        .frame(height: 40.0)
                    HStack{
                        if model.bookList.indices.contains(index) {
                            VStack {
                                Button {
                                    //go some where
                                } label: {
                                    VStack(alignment:.leading) {
                                        let book = model.bookList[0]
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
                        }
                    }
                }.navigationTitle("Library")
                    .padding()
            }
        }
    }
    init(){
        model.getBookData()
    }
}

#Preview {
    Library()
}
