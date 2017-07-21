//
//  SignInVC.swift
//  SocialApp
//
//  Created by Jeremy Clerico on 19/07/2017.
//  Copyright © 2017 Jeremy Clerico. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Save UID to keychain and retrieve it if it exists. Save the UID when we authenticate a user. When view loads, we want to try and retrieve that UID and see if it exists. If the UID exists, segue the user to the new VC
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("JEREMY: ID Found in Keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        } //Above is checking for a string of KEY_UID, and if it finds one perform the segue, if not carry on as normal.
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        //Asking users facebook account for permission to see their email. If successful get credential from access token which we use to create the credential and pass into firebaseAuth method.
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("JEREMY: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("JEREMY: User cancelled Facebook Authentication")
            } else {
                print("JEREMY: Sucessfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    //Authenticate with FireBase
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("JEREMY: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JEREMY: Sucessfully authenticated with Firebase")
                if let user = user {
                    KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                    self.completeSignIn(id: user.uid)
                }
                
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        //Checking if there is text inside the fields before proceeding.
        if let email = emailField.text, let pwd = pwdField.text {
            //Try signing in first with details before creating new account for user
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("JEREMY: Email User Authenticated With Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("JEREMY: Unable To Authenticate Email With Firebase")
                        } else {
                            print("JEREMY: Successfully Authenticated With Firebase")
                            if let user = user {
                               self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    //Complete Sign In For Auto Sign in
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("JEREMY: Data Saved To Keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

