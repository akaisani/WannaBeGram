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
import FirebaseStorage

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
    
    static func createUser(withEmail email: String, password: String, username: String, profileImage: UIImage, completion: @escaping (User?, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
            guard error == nil else {
                completion(nil, error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                completion(nil, "User data could not be created!")
                return
            }
            
            
            
            let database = Database.database().reference().child("users").child(data.user.uid)
            
            let imageRef = StorageReference.newProfileImageReference(usingUID: data.user.uid)
            StorageService.uploadImage(profileImage, at: imageRef) { (downloadURL) in
                guard let downloadURL = downloadURL else {
                    return
                }
                
                let urlString = downloadURL.absoluteString
                
                
                let userData = [
                    "username": username,
                    "profileImageURL": urlString
                ]
                
                database.setValue(userData, withCompletionBlock: { (error, databaseRef) in
                    guard error == nil else {
                        completion(nil, "Could not write user data to database, please try again!")
                        return
                    }
                    
                    databaseRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let user = User(snapshot: snapshot) else {
                            completion(nil, "Error Fetching data for newly created user!")
                            return
                        }
                        
                        User.setCurrent(user)
                        completion(user, nil)
                        return
                    })
                })
            }
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
            var posts = [Post]()
            
            guard snapshot.count > 0 else {return completion([])}
            
            for snap in snapshot {
                guard let snapshot = snap.children.allObjects as? [DataSnapshot]
                    else { return completion([]) }
                let dispatchGroup = DispatchGroup()
                
                
                for postSnap in snapshot {
                    guard let postDict = postSnap.value as? [String : Any],
                        let posterUID = postDict["poster_uid"] as? String
                        else { continue }
                    
                    dispatchGroup.enter()
                    
                    PostService.show(forKey: postSnap.key, posterUID: posterUID) { (post) in
                        if let post = post {
                            _ = post.image
                            _ = post.userProfileImage
                            posts.append(post)
                        }
                        
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main, execute: {
                    completion(posts)
                })
                
            }
            
        })
        
    }
    
    static func signOut() {
        try! Auth.auth().signOut()
    }
    
}

