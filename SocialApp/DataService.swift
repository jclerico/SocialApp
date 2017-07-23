//
//  DataService.swift
//  SocialApp
//
//  Created by Jeremy Clerico on 22/07/2017.
//  Copyright © 2017 Jeremy Clerico. All rights reserved.
//

import Foundation
import Firebase

//Contains the url of the root of our database (See DATABASE_URL in google plist file)
let DB_BASE = Database.database().reference()

//Storage for cache images
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    //Singleton - is an instance of a class thats globally accessible and theres only one instance
    static let ds = DataService()
    
    //DB References
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    //Storage References
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POST_IMAGES: StorageReference {
        return _REF_POST_IMAGES
    }
    
    //Create Users using references above
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        //If UID Doesnt exist, firebase will automatically create it. If UID is being created then data will be added to it (e.g. likes, posts etc), but if UID already exists, firebase wont overwrite current data, just add new data
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
    
    
    
    
    
    
}







