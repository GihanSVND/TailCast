//
//  viewModel.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-19.
//

import Foundation
import Firebase

class ViewModel: ObservableObject{
    @Published var list = [Authors]()
    
    func getData(){
        let db = Firestore.firestore()
        
        db.collection("Authors").getDocuments { snapshot, error in
            if error == nil{
                //no errors
                if let snapshot = snapshot{
                    
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { docs in
                            return Authors(Id: docs.documentID, Name: docs["Name"] as? String ?? "", Book: docs["Book"] as? String ?? "")
                        }
                    }
                }
            }else{
                //there is an error
            }
        }
    }
    
}
