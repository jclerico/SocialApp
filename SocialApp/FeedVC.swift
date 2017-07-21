//
//  FeedVC.swift
//  SocialApp
//
//  Created by Jeremy Clerico on 21/07/2017.
//  Copyright © 2017 Jeremy Clerico. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        //Sign out of Firebase and remove Keychain so back to start.
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("JEREMY: ID Removed From Keychain \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
