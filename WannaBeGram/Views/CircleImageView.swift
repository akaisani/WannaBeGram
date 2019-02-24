//
//  CircleImageView.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/18/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        
        
        
    }
    
    
    
    
    
}
