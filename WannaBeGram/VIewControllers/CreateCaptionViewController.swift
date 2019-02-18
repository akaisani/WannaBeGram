//
//  CreateCaptionViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class CreateCaptionViewController: UIViewController {

    
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
        
    }
    
    @IBAction func didAttemptEditinigCaption(_ sender: UITextField) {
    print("here")
        self.resignFirstResponder()
        
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

extension CreateCaptionViewController: UITextFieldDelegate {
    
    
    
}
