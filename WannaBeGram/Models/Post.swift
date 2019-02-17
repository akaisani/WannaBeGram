//
//  Post.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit


class Post {
    var key: String?
    let imageURL: String
    let creationDate: Date
    var likeCount: Int
    let poster: User
    var isLiked = false
    
    var cachedImage: UIImage?

    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.creationDate = Date()
        self.likeCount = 0
        self.poster = User.current
    }
    
    var image: UIImage {
        if let image = cachedImage {
            return image
        }
        
        let url = URL(string: imageURL)!
        let data = try! Data(contentsOf: url)
        let image = UIImage(data: data)
        cachedImage = image
        return image
    }
    
}
