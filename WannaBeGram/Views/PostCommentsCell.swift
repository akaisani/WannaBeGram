//
//  PostCommentsCell.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/22/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class PostCommentsCell: UITableViewCell {

    var commentViewAction: (() -> Void)?
    
    @IBAction func didPressViewComments(_ sender: UIButton) {
        commentViewAction?()
    }
}
