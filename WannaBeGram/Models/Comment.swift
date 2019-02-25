//
//  File.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/24/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Comment {
    
    let text: String
    let username: String
    private let userProfileImageURL: String
    var key: String?
    
    init(text: String, username: String, userProfileImageURL: String) {
        self.text = text
        self.username = username
        self.userProfileImageURL = userProfileImageURL
    }
    
    private var cachedUserImage: UIImage?
    
    var dictValue: [String: Any] {
        
        return [
            "text": self.text,
            "username": self.username,
            "userProfileImageURL": self.userProfileImageURL
        ]
    }
    
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String,
            let userProfileImageURL = dict["userProfileImageURL"] as? String,
            let text = dict["text"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.username = username
        self.userProfileImageURL = userProfileImageURL
        self.text = text
    }
    
    
    var userProfileImage: UIImage {
        if let image = cachedUserImage {return image}
        else {
            let url = URL(string: userProfileImageURL)!
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)
            cachedUserImage = image
            return image!
        }
    }
    
    
    
}


