//
//  WBGButton.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class WBGButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
    
    }
    

}
