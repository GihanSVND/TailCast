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
    @State var bookCover2: UIImage?
    @State var pdfUrl: URL?
    @AppStorage("uId") var userID: String = ""
    let index: Int = 1
    @State private var pdfURLs: [URL?] = [] // Array to store PDF URLs
    @State private var showPDF = false
    @State private var selectedPDFUrl: URL?
    @State private var bookCovers: [UIImage?] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                    Text("Favourites")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                        .frame(height: 40.0)
                    
                    VStack{
                        
                        ForEach(model.bookList.indices, id: \.self) { index in
                            let book = model.bookList[index]
                            if book.Favourite == "yes"{
                                VStack {
                                
                                Button {
                                    // Handle navigation or action
                                } label: {
                                    
                                    // Check if the cover image is already loaded
                                    if let image = bookCovers.indices.contains(index) ? bookCovers[index] : nil {
                                        
                                        HStack() {
                                            Image(uiImage: image)
                                                .resizable()
                                                .frame(width: 157, height: 207)
                                                .cornerRadius(7)
                                                .shadow(color: .black, radius: 0, x: 5, y: 5)
                                            Spacer()
                                                .frame(width: 30.0)
                                            VStack{
                                                
                                                Text(book.Name)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(width: 160)
                                                    .lineLimit(nil)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.black)
                                                    .padding(.top, 5.0)
                                                
                                                Text(book.Author)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(width: 160)
                                                    .lineLimit(nil)
                                                    .font(.footnote)
                                                    .foregroundColor(Color.black)
                                                Spacer()
                                                if let pdfURL = pdfURLs.indices.contains(index) ? pdfURLs[index] : nil {
                                                    NavigationLink(destination: PDFViewerView(url: pdfURL)) {
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 7)
                                                                .frame(height: 60)
                                                                .foregroundColor(.black)
                                                                .offset(x:7,y:5)
                                                            
                                                            Text("Read")
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
                                                    }
                                                }else {
                                                    ZStack{
                                                        RoundedRectangle(cornerRadius: 7)
                                                            .frame(height: 60)
                                                            .foregroundColor(.black)
                                                            .offset(x:7,y:5)
                                                        
                                                        Text("Read")
                                                            .foregroundColor(.white)
                                                            .padding()
                                                            .frame(maxWidth: .infinity)
                                                            .background(Color.gray)
                                                            .cornerRadius(7)
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 7)
                                                                    .stroke(Color.white,lineWidth: 3)
                                                            }
                                                    }
                                                    
                                                    
                                                    .onAppear {
                                                        book.downloadBookPDF { url in
                                                            if let url = url {
                                                                if pdfURLs.indices.contains(index) {
                                                                    pdfURLs[index] = url
                                                                } else {
                                                                    pdfURLs.append(url)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }.padding()
                                    } else {
                                        HStack{
                                            ProgressView()
                                                .frame(width: 157, height: 207)
                                                .cornerRadius(7)
                                                .onAppear {
                                                    book.loadBookCover { img in
                                                        if bookCovers.indices.contains(index) {
                                                            bookCovers[index] = img
                                                        } else {
                                                            bookCovers.append(img)
                                                        }
                                                    }
                                                }
                                            Spacer()
                                                .frame(width: 30.0)
                                            VStack{
                                                Text(book.Name)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(width: 160)
                                                    .lineLimit(nil)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.black)
                                                    .padding(.top, 5.0)
                                                
                                                Text(book.Author)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(width: 160)
                                                    .lineLimit(nil)
                                                    .font(.footnote)
                                                    .foregroundColor(Color.black)
                                                Spacer()
                                                if let pdfURL = pdfURLs.indices.contains(index) ? pdfURLs[index] : nil {
                                                    NavigationLink(destination: PDFViewerView(url: pdfURL)) {
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 7)
                                                                .frame(height: 60)
                                                                .foregroundColor(.black)
                                                                .offset(x:7,y:5)
                                                            
                                                            Text("Read")
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
                                                    }
                                                }else {
                                                    ZStack{
                                                        RoundedRectangle(cornerRadius: 7)
                                                            .frame(height: 60)
                                                            .foregroundColor(.black)
                                                            .offset(x:7,y:5)
                                                        
                                                        Text("Read")
                                                            .foregroundColor(.white)
                                                            .padding()
                                                            .frame(maxWidth: .infinity)
                                                            .background(Color.gray)
                                                            .cornerRadius(7)
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 7)
                                                                    .stroke(Color.white,lineWidth: 3)
                                                            }
                                                    }
                                                    .onAppear {
                                                        book.downloadBookPDF { url in
                                                            if let url = url {
                                                                if pdfURLs.indices.contains(index) {
                                                                    pdfURLs[index] = url
                                                                } else {
                                                                    pdfURLs.append(url)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }.padding()
                                    }
                                }
                                
                                
                                Divider()
                            }
                        }
                            
                            //.frame(width: 160, height: 215)
                        }.onAppear {
                            pdfURLs = Array(repeating: nil, count: model.bookList.count)
                            // Initialize the array with the same count as bookList
                            bookCovers = Array(repeating: nil, count: model.bookList.count)
                        }
                        
                    }.padding()
                }
                .navigationTitle("Library")
                .padding()
                
            }
        }
    }
    
    init() {
        model.getBookData()
        
    }
    
    // Function to fetch the PDF from Firebase Storage
    func fetchPDFLink(_ bookLink: String) {
        let storageRef = Storage.storage().reference(withPath: bookLink)
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error getting PDF link: \(error.localizedDescription)")
                return
            }
            if let url = url {
                self.pdfUrl = url
                self.showPDF = true
            }
        }
    }
}
