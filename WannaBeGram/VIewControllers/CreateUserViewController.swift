//
//  CreateUserViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/15/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    var email: String!
    var password: String!
    
    let photoHelper = PhotoHelper()
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self

        setupImageView()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressRegisterButton(_ sender: UIButton) {
        guard let username = usernameField.text else {
            AlertControllerHelper.presentAlert(for: self, withTitle: "Error!", withMessage: "username field is empty.")
            return
        }
        
        guard let image = self.userProfileImageView.image else {
            AlertControllerHelper.presentAlert(for: self, withTitle: "Error!", withMessage: "No user profile image selected!")
            return
        }
        
        UserService.createUser(withEmail: email, password: password, username: username, profileImage: image) { (user, errorString) in
            guard let _ = user else {
                AlertControllerHelper.presentAlert(for: self, withTitle: "Error!", withMessage: "Could not create user with username: \(username)\n\(errorString!)")
                return
            }
            
            UserService.loginUser(email: self.email, password: self.password, completion: { (currUser) in
                guard let _ = currUser else {
                    AlertControllerHelper.presentAlert(for: self, withTitle: "Error!", withMessage: "Could not login user with username: \(username)")
                    return
                }
                self.usernameField.resignFirstResponder()
                
                let initialVC = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialVC
                self.view.window?.makeKeyAndVisible()
            })
            
            
        }
    }
    
    //MARK: - Helpers
    
    
    func setupImageView() {
        self.userProfileImageView.clipsToBounds = true
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.bounds.width / 2
        self.userProfileImageView.layer.borderColor = UIColor.white.cgColor
        self.userProfileImageView.layer.borderWidth = 2

    }
    
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        self.photoHelper.completionHandler = {(image) in
            self.userProfileImageView.image = image
        }
        self.photoHelper.show(for: self)
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

extension CreateUserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
