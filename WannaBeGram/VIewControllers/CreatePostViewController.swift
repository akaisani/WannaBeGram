//
//  CreatePostViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    let photoHelper = PhotoHelper()
    
    var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        photoHelper.completionHandler = {(UIImage) in
            self.performSegue(withIdentifier: "toCaptionView", sender: self)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        photoHelper.show(for: self)
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
