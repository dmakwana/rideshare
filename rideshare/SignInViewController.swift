//
//  SignInViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-13.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, FBSDKLoginButtonDelegate {

    let user = User.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            returnUserData()
            // User is already logged in, do work such as go to next view controller.
        }
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email"){
            
                // Do work
            }
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    

    func returnUserData()
    {
        var params = [String:String]()
        params["fields"] = "id,name,email"
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let fullName : String = result.valueForKey("name") as! String
                if (fullName != "") {
                    self.user.full_name = fullName
                }
                
                let email : String = result.valueForKey("email") as! String
                if (email != "") {
                    self.user.email = email
                }
                
                let fbid: String = result.valueForKey("id") as! String
                if (fbid != "") {
                    let pp_url = "http://graph.facebook.com/" + fbid + "/picture?type=large"
                    self.user.profile_picture = pp_url
                }
                
                let access_token: String = FBSDKAccessToken.currentAccessToken().tokenString
                if (access_token !=  "") {
                    self.user.access_token = access_token
                }
            }
        })
    }
    

}
