//
//  HomeTabBarController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    let photoHelper = PhotoHelper()
    
    var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.delegate = self
        photoHelper.completionHandler = {(image) in
            self.capturedImage = image
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toCaptionView", sender: self)
            }
        }
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let identifier = segue.identifier else {return}
        if identifier == "toCaptionView" {
            guard let captionVC = segue.destination as? CreateCaptionViewController else {return}
            captionVC.image = self.capturedImage
        }
        
    }

}

extension HomeTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print(viewController.tabBarItem.tag)
        if viewController.tabBarItem.tag == 1 {
            photoHelper.show(for: self)
            return false
        } else {
            return true
        }
    }

}
