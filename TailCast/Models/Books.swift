//
//  Books.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-07.
//

import Foundation
import UIKit
import FirebaseStorage

class Books: Identifiable{
    
    var id: String
    var Name: String
    var Author: String
    var BookLink: String
    var BookCoverPage: String
    var Favourite: String
    
    init(id: String, Name: String, Author: String, BookLink: String, BookCoverPage: String, Favourite: String) {
        self.id = id
        self.Name = Name
        self.Author = Author
        self.BookLink = BookLink
        self.BookCoverPage = BookCoverPage
        self.Favourite = Favourite
    }
    
    func loadBookCover(completion: @escaping (UIImage?) -> Void) {
        
        let storageReference = Storage.storage().reference(withPath: BookCoverPage)
        storageReference.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let data = data, error == nil {
                completion(UIImage(data: data))
                
            } else {
                print("Error loading image: \(String(describing: error))")
                completion(nil)
            }
        }
    }
    
    func downloadBookPDF(completion: @escaping (URL?) -> Void) {
        let storageReference = Storage.storage().reference(withPath: BookLink)

        // Create a local URL for the PDF file in the app's Documents directory
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localURL = documentDirectory.appendingPathComponent("\(UUID().uuidString).pdf")

        // Download the PDF file to the local URL
        storageReference.write(toFile: localURL) { url, error in
            if let error = error {
                print("Error downloading PDF: \(error.localizedDescription)")
                completion(nil)
            } else {
                print("PDF downloaded successfully to: \(localURL)")
                completion(localURL)
            }
        }
    }
}
