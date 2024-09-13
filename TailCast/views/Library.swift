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
    @State private var showPDF = false
    @State private var pdfURL: URL?
    
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
                    
                    HStack {
                        if model.bookList.indices.contains(index) {
                            VStack {
                                let book = model.bookList[0]
                                
                                if let pdfURL = pdfURL {
                                    NavigationLink(destination: PDFViewerView(url: pdfURL)){
                                        Text("Edit User Profile")
                                    }
                                }else{
                                    Text("Loading pdf")
                                        .onAppear {
                                            book.downloadBookPDF { url in
                                                if let url = url {
                                                    self.pdfURL = url
                                                }
                                            }
                                        }
                                }
                                Button {
                                    //
                                    
                                } label: {
                                    VStack(alignment: .leading) {
                                        let book = model.bookList[index]
                                        if let image = bookCover2 {
                                            // Displaying only the book cover as an image
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
                                        } else {
                                            ProgressView()
                                                .frame(width: 157, height: 207)
                                                .cornerRadius(7)
                                                .onAppear {
                                                    book.loadBookCover { img in
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
                            }.frame(width: 160, height: 215)
                        }
                    }
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
