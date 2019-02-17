//
//  AlertControllerHelper.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/15/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

struct AlertControllerHelper {
    
    static func presentAlert(for viewController: UIViewController, withTitle title: String, withMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
