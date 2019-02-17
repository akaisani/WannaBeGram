//
//  LoginViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/11/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordFIeld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressLoginButton(_ sender: UIButton) {
        guard let email = emailField.text, let password = passwordFIeld
            .text else {
                AlertControllerHelper.presentAlert(for: self, withTitle: "Error", withMessage: "Email or password fields are empty")
                return
        }
        
        UserService.loginUser(email: email, password: password) { (user) in
            guard let _ = user else {
                self.performSegue(withIdentifier: "toCreateUser", sender: self)
                return
            }
            self.passwordFIeld.resignFirstResponder()
            let initialVC = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialVC
            self.view.window?.makeKeyAndVisible()
            
        }
        
        
        
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {return}
        if identifier == "toCreateUser" {
            guard let createUserVC = segue.destination as? CreateUserViewController else {return}
            createUserVC.email = self.emailField.text!
            createUserVC.password = self.passwordFIeld.text!
        }
    }

}
