//
//  CommentService.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/24/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct CommentService {
    func makeComment(_ comment: String, for post: Post, completion: @escaping (Post?) -> Void) {
        let commentDict = [post.poster.uid: comment]
        post.comments.append(commentDict)
        guard let key = post.key else {return}
        let databaseRef = Database.database().reference().child("posts").child(key)
    
        
        databaseRef.updateChildValues(post.commentsDict) { (error, reference) in
            if error != nil {
                completion(nil)
            } else {
                PostService.show(forKey: key, posterUID: post.poster.uid, completion: { (updatedPost) in
                    completion(updatedPost)
                })
            }
        }
        
    }
}
