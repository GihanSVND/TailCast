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
    
    init(id: String, Name: String, Author: String, BookLink: String) {
        self.id = id
        self.Name = Name
        self.Author = Author
        self.BookLink = BookLink
    }
}
