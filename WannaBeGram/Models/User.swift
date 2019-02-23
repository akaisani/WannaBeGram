//
//  User.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/15/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: Codable {
    // MARK: - Properties
    
    let uid: String
    let username: String
    let profileImageURL: String

    private static var _current: User?
    
    static var current: User {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        return currentUser
    }
    
    // MARK: - Class Methods
    
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        
        _current = user
    }

    // MARK: - Init
    
    init(uid: String, username: String, profileImageURL: String) {
        self.uid = uid
        self.username = username
        self.profileImageURL = profileImageURL
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String,
            let profileImageURL = dict["profileImageURL"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        self.profileImageURL = profileImageURL
    }
}
