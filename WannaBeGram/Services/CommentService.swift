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
    static func makeComment(_ comment: String, for post: Post, completion: @escaping (Comment?) -> Void) {
        guard let postKey = post.key else {return}
        
        let databaseRef = Database.database().reference().child("comments").child(postKey).childByAutoId()
        
        
        let newComment = Comment(text: comment, username: post.poster.username, userProfileImageURL: post.poster.profileImageURL)
        
        databaseRef.setValue(newComment.dictValue) { (error, reference) in
            if let _ = error {
                completion(nil)
            } else {
                reference.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let comment = Comment(snapshot: snapshot) else {completion(nil);return;}
                    completion(comment)
                })
                
            }
        }
        
    }
    
    static func getCommentsForPost(_ post: Post, completion: @escaping ([Comment]?) -> Void) {
        guard let postKey = post.key else {return}
        var comments = [Comment]()
        
        let databaseRef = Database.database().reference().child("comments").child(postKey)
        
        databaseRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion(comments) }
            
            let dispatchGroup = DispatchGroup()
            
            for commentSnap in snapshot {
                guard let comment = Comment(snapshot: commentSnap) else {continue}
                dispatchGroup.enter()
                
                _ = comment.userProfileImage
                comments.append(comment)

                dispatchGroup.leave()
                
                
                
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                
                completion(comments)
                
            })
            
            
        }
        
    }
    
    
    
}
