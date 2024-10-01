//
//  viewModel.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import Foundation
import Firebase

class ViewModel: ObservableObject{
    @Published var authorsList = [Authors]()
    @Published var usersList = [Users]()
    @Published var bookList = [Books]()
    @Published private var favouriteStatuses: [String] = []
    
    func getAuthorData(){
        let db = Firestore.firestore()
        
        db.collection("Authors").getDocuments { snapshot, error in
            if error == nil{
                //no errors
                if let snapshot = snapshot{
                    
                    DispatchQueue.main.async {
                        self.authorsList = snapshot.documents.map { docs in
                            return Authors(Id: docs.documentID, Name: docs["Name"] as? String ?? "", Book: docs["Book"] as? String ?? "", imageURL: docs["imageURL"] as? String ?? "")
                        }
                    }
                }
            }else{
                //there is an error
            }
        }
    }
    
    
    func getUserData(){
        let db = Firestore.firestore()
        
        db.collection("User").getDocuments {snapshot , error in
            if error == nil{
                
                if let snapshot = snapshot{
                    
                    DispatchQueue.main.async {
                        self.usersList = snapshot.documents.map {docs in
                            return Users(Id: docs.documentID, userID: docs["userID"] as? String ?? "", Name: docs["name"] as? String ?? "", Bio: docs["bio"] as? String ?? "", imageURL: docs["imageURL"] as? String ?? "")
                        }
                    }
                }
                
            } else{
                print("Error fetching user data: \(String(describing: error))")
            }
        }
    }
    
    func getBookData(){
        let db = Firestore.firestore()

        db.collection("Books").getDocuments { snapshot , error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.bookList = snapshot.documents.map { docs in
                            return Books(id: docs.documentID, Name: docs["Name"] as? String ?? "", Author: docs["Author"] as? String ?? "", BookLink: docs["BookLink"] as? String ?? "", BookCoverPage: docs["BookCoverPage"] as? String ?? "", Favourite: docs["Favourite"] as? String ?? "")
                        }

                        // Initialize favouriteStatuses array based on the fetched books
                        self.favouriteStatuses = self.bookList.map { book in
                            return book.Favourite == "yes" ? "yes" : "no"
                        }
                    }
                }
            } else {
                print("Error fetching book data: \(String(describing: error))")
            }
        }
    }


}
