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

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("JEREMY: Unable To Authenticate Email With Firebase")
                        } else {
                            print("JEREMY: Successfully Authenticated With Firebase")
                        }
                    })
                }
            })
        }
    }

}

