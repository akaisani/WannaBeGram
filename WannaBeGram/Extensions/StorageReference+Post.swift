//
//  StorageReference+Post.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/17/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
    
    static func newProfileImageReference() -> StorageReference {
        let uid = User.current.uid
//        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/profileImage/\(uid).jpg")
    }
}
