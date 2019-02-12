//
//  LoginViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/11/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gradientLayer = CAGradientLayer(layer: self.view.layer)
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.blue, UIColor.red]
        self.view.layer.addSublayer(gradientLayer)
        // Do any additional setup after loading the view.
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
