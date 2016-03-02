//
//  FacebookViewController.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 25/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

/**
  * TableViewController that handles the Login and Logout with Facebook,
  * any views that requied to implement facebook login should extend from this
  * view controller.
  */
class FacebookLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
  
  //# MARK: - View Outlet
  @IBOutlet var facebookButton: FBSDKLoginButton!
  
  //# MARK: FacebookLoginViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if(FBSDKAccessToken.currentAccessToken() == nil) {
      print("NOT LOGIN IN")
    }
    else {
      print("LOGGED IN")
    }
    
    //Facebook Configuration
    facebookButton.readPermissions = ["public_profile", "email", "user_friends"]
    facebookButton.publishPermissions = ["publish_actions"]
    facebookButton.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //# MARK: - Facebook Login
  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    
    if (error == nil) {
      if (FBSDKAccessToken.currentAccessToken() != nil) {
        
        //When Loggin in through facebook, Need to login to PHS
        AppAPI.LoginIntoPHSThroughFacebook()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue("4305", forKey: AppUserDefaultsConstants.UserId)
        userDefaults.setValue("a74196e18eff04020761", forKey: AppUserDefaultsConstants.UserToken)
        
        AppData.UserToken = "a74196e18eff04020761"
        
        //Method to be Overriden in each implementation when user logs in using Facebook.
        userHasLoggedIn()
      }
    }
    else {
      let alert = UIAlertController(title: "Pet Home Stay", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  //# MARK: - Methods to Override! Always call super!
  func userHasLoggedIn() {
    print("User Logged In")    
  }
  
  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    
  }
}