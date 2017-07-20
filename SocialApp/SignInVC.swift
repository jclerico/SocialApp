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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

