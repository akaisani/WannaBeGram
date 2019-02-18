//
//  FirebaseHelper.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/15/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

struct UserService {
    
    
    static func getUser(withUID uid: String, completion: @escaping (User?)-> Void) {
        let database = Database.database().reference().child("users").child(uid)
        database.observeSingleEvent(of: .value) { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                completion(nil)
                return
            }
            User.setCurrent(user, writeToUserDefaults: true)
            completion(user)
        }
    }
    
    static func createUser(withEmail email: String, password: String, username: String, completion: @escaping (User?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
            guard error == nil else {
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            let database = Database.database().reference().child("users").child(data.user.uid)
            
            let userData = [
                "username": username
            ]
            
            database.setValue(userData, withCompletionBlock: { (error, databaseRef) in
                guard error == nil else {
                    completion(nil)
                    return
                }
                
                databaseRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let user = User(snapshot: snapshot) else {
                        completion(nil)
                        return
                    }
                    
                    User.setCurrent(user)
                    completion(user)
                    return
                })
            })
        }
    }
    
    static func loginUser(email: String, password: String, completion: @escaping (User?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = result else {
                completion(nil)
                return
            }
            
            let database = Database.database().reference().child("users").child(data.user.uid)
            
            database.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let user = User(snapshot: snapshot) else {completion(nil);return;}
                User.setCurrent(user, writeToUserDefaults: true)
                completion(user)
            })
            
        }
    }
    
    static func timeline(completion: @escaping ([Post]) -> Void) {
//        let currentUser = User.current
        
        let timelineRef = Database.database().reference().child("timeline")
        timelineRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            for snap in snapshot {
                guard let snapshot = snap.children.allObjects as? [DataSnapshot]
                    else { return completion([]) }
            let dispatchGroup = DispatchGroup()
            
            var posts = [Post]()
            
            for postSnap in snapshot {
                guard let postDict = postSnap.value as? [String : Any],
                    let posterUID = postDict["poster_uid"] as? String
                    else { continue }
                
                dispatchGroup.enter()
                
                PostService.show(forKey: postSnap.key, posterUID: posterUID) { (post) in
                    if let post = post {
                        _ = post.image
                        posts.append(post)
                    }
                    
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(posts.reversed())
            })
        
            }
            
        })
        
    }
    
}

