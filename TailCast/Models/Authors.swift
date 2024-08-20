//
//  Authors.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import Foundation


class Authors: Identifiable{
    
    var Id: String
    var Name: String
    var Book: String
    
    init(Id: String, Name: String, Book: String) {
        self.Id = Id
        self.Name = Name
        self.Book = Book
    }
}
