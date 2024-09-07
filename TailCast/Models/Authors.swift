//
//  Authors.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import Foundation
import UIKit
import FirebaseStorage


class Authors: Identifiable{
    
    var Id: String
    var Name: String
    var Book: String
    var imageURL: String
    
    init(Id: String, Name: String, Book: String, imageURL: String) {
        self.Id = Id
        self.Name = Name
        self.Book = Book
        self.imageURL = imageURL
    }
    func loadAuthorImage(completion: @escaping (UIImage?) -> Void) {
        
        let storageReference = Storage.storage().reference(withPath: imageURL)
        storageReference.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let data = data, error == nil {
                completion(UIImage(data: data))
            } else {
                print("Error loading image: \(String(describing: error))")
                completion(nil)
            }
        }
    }
}
