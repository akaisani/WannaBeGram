//
//  Post.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    var key: String?
    let imageURL: String
    let creationDate: Date
    var likeCount: Int
    let poster: User
    var isLiked = false
    let caption: String
    
    var cachedImage: UIImage?
    
    var dictValue: [String : Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        let userDict = ["uid" : poster.uid,
                        "username" : poster.username]
        
        return ["image_url" : imageURL,
                "created_at" : createdAgo,
                "like_count" : likeCount,
                "caption": caption,
                "poster" : userDict]
    }
    
    init(imageURL: String, caption: String) {
        self.imageURL = imageURL
        self.creationDate = Date()
        self.likeCount = 0
        self.poster = User.current
        self.caption = caption
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let imageURL = dict["image_url"] as? String,
            let createdAgo = dict["created_at"] as? TimeInterval,
            let likeCount = dict["like_count"] as? Int,
            let userDict = dict["poster"] as? [String : Any],
            let uid = userDict["uid"] as? String,
            let profileImageURL = userDict["profileImageURL"] as? String,
            let username = userDict["username"] as? String,
            let caption = dict["caption"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.imageURL = imageURL
        self.creationDate = Date(timeIntervalSince1970: createdAgo)
        self.likeCount = likeCount
        self.caption = caption
        self.poster = User(uid: uid, username: username, profileImageURL: profileImageURL)
    }
    
    var image: UIImage {
        if let image = cachedImage {
            return image
        }
        
        let url = URL(string: imageURL)!
        let data = try! Data(contentsOf: url)
        let image = UIImage(data: data)
        cachedImage = image
        return cachedImage!
    }
    
}
