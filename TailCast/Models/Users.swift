//
//  Users.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-29.
//

import Foundation
import UIKit
import FirebaseStorage

class Users: Identifiable{
    
    var id: String
    var userID: String
    var Name: String
    var Bio: String
    var imageURL: String
    
    init(Id: String,userID: String, Name: String, Bio: String, imageURL: String) {
        self.id = Id
        self.userID = userID
        self.Name = Name
        self.Bio = Bio
        self.imageURL = imageURL
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        
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
