//
//  File.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class PhotoHelper: NSObject {
    
    var completionHandler: ((UIImage) -> Void)?
    
    func show(for viewController: UIViewController) {
        let alertController = UIAlertController(title: "Select a method to take an image", message: "", preferredStyle: .actionSheet)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.presentImagePicker(from: viewController, of: .camera)
            }
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            
            let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                self.presentImagePicker(from: viewController, of: .photoLibrary)
            }
            alertController.addAction(libraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            viewController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    private func presentImagePicker(from viewcontroller: UIViewController, of type: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        viewcontroller.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
}


extension PhotoHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {picker.dismiss(animated: true, completion: nil);return}
        completionHandler?(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
