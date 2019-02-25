//
//  CircleImageView.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/18/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }

}
