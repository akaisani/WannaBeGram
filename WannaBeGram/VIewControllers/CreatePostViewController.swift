//
//  CreateCaptionViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var capturedImageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.captionField.delegate = self
        self.capturedImageView.image = image
        // Do any additional setup after loading the view.
        
        
        let tapGestureRecongnizer:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGestureRecongnizer)
        
        
        
        
    }
    
    //MARK:- Helper Functions
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        if self.captionField.isFirstResponder {
            self.captionField.resignFirstResponder()
        }
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        PostService.create(for: image, caption: captionField.text!)
        let alertController = UIAlertController(title: "Success!", message: "Your post was created!", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) {(action) in
            alertController.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreatePostViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let alertController = UIAlertController(title: "Caption", message: "Enter Caption Text Below", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Caption"
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        
        let okayAction = UIAlertAction(title: "Done", style: .default) { (action) in
            guard let textField = alertController.textFields?.first else {return}
            self.captionField.text = textField.text
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
        return false
    }
    
    
}
