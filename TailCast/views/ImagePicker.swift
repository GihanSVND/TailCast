//
//  ImagePicker.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-08-20.
//

import Foundation
import UIKit
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var selecteImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

class Coordinator: NSObject , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    var parent: ImagePicker
    
    init(_ picker : ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.parent.selecteImage = image
        }
        parent.isPickerShowing = false
    }
    
}
