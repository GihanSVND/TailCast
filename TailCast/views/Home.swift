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
    @State private var bookCovers: [UIImage?] = []
    @State var bookCover1: UIImage?
    @State var bookCover2: UIImage?
    @State var bookCover3: UIImage?
    @AppStorage("uId") var userID: String = ""
    @State private var pdfURLs: [URL?] = [] // Array to store PDF URLs
    @State private var showPDF = false
    @State private var selectedPDFUrl: URL?
    @State private var favouriteStatuses: [String] = []
    
    //let items = ["Apple", "Banana", "Orange"]
    
    let indexs: Int = 1
    
    @State var selectedView = 0
    var body: some View {
        NavigationStack{
            
            ScrollView{
                Divider()
                ZStack{
                    
                    VStack(alignment: .leading){
                        
                        Text("Top Authors")
                        
                        Spacer()
                            .frame(height: 5.0)
                        if model.authorsList.indices.contains(indexs) {
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
                                ForEach(model.bookList.indices, id: \.self) { index in
                                    VStack {
                                        let book = model.bookList[index]
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
                                                        
                                                        
                                                        Toggle(isOn: Binding(
                                                            get: {
                                                                // Check if the index exists in favouriteStatuses and convert the value to a boolean
                                                                favouriteStatuses.indices.contains(index) ? (favouriteStatuses[index] == "yes") : false
                                                            },
                                                            set: { newValue in
                                                                // Update the favouriteStatuses array based on the toggle's new value
                                                                favouriteStatuses[index] = newValue ? "yes" : "no"
                                                                
                                                                // Update Firestore with the new value
                                                                book.updateFavouriteStatus(isFavourite: newValue) { error in
                                                                    if let error = error {
                                                                        print("Error updating favourite status: \(error.localizedDescription)")
                                                                    }
                                                                }
                                                            }
                                                        )) {
                                                            Text("Favourite")
                                                        }
                                                        .onAppear {
                                                            // Check if the toggle status is already initialized
                                                            if favouriteStatuses.indices.contains(index) {
                                                                return // Skip if already initialized
                                                            }
                                                            
                                                            // Set the toggle status based on the "Favourite" field of the book
                                                            let isFavourite = book.Favourite == "yes"
                                                            favouriteStatuses.append(isFavourite ? "yes" : "no")
                                                        }

                                                        
                                                        
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
                                    //.frame(width: 160, height: 215)
                                }.onAppear {
                                    pdfURLs = Array(repeating: nil, count: model.bookList.count)
                                    bookCovers = Array(repeating: nil, count: model.bookList.count)
                                    favouriteStatuses = Array(repeating: "no", count: model.bookList.count)

                                }
                                
                            }.padding()
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            .padding()
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
