//
//  PostHeaderCell.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/16/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: CircleImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var optionsButton: UIButton!
    override func draw(_ rect: CGRect) {
        self.optionsButton.layer.borderWidth = 0
    }

}
