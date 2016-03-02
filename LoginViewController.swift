//
//  ViewController.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/8/18.
//  Modified by Juan Diego Delgado Vargas 24/08/2015
//  Copyright (c) 2015 rmit. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

/**
  * Login View Controller.
  * This view controller is no longer used because it was replaced by the Signup ViewController.
  */
class LoginViewController: FacebookLoginViewController {
  
  //# MARK: - View Outlets
  @IBOutlet var passwordtextField: UITextField!
  @IBOutlet var usernametextField: UITextField!
  @IBOutlet var loginButton: UIButton!
  
  //# MARK: LoginViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if(FBSDKAccessToken.currentAccessToken() == nil) {
      print("NOT LOGIN IN")
    }
    else {
      print("LOGGED IN")
    }
    
    //Set Text placeholder to White.
    usernametextField.attributedPlaceholder = NSAttributedString(string:"username",attributes:[NSForegroundColorAttributeName: AppConstants.Colors.Orange])
    passwordtextField.attributedPlaceholder = NSAttributedString(string:"password",attributes:[NSForegroundColorAttributeName: AppConstants.Colors.Orange])
    
    //Add Observer when Keyboard is displayed and hidden.
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    
    //Tag anywhere else, hide keyboard.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
    view.addGestureRecognizer(tap)
    
    //Map Delegates!
    loginButton.addTarget(self, action: "buttonLoginAction:", forControlEvents: UIControlEvents.TouchUpInside)
    usernametextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    passwordtextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //# MARK: - Keyboard Displayed/Hidden
  func DismissKeyboard(){
    view.endEditing(true)
  }
  
  func keyboardWillShow(sender: NSNotification){
    self.view.frame.origin.y -= 150
  }
  
  func keyboardWillHide(sender: NSNotification){
    self.view.frame.origin.y += 150
  }
  
  //# MARK: - TextField Handlers
  func textFieldDidChange(textField: UITextField) {
    if (usernametextField.text!.isEmpty || passwordtextField.text!.isEmpty) {
      loginButton.enabled = false
      loginButton.backgroundColor = UIColor.lightGrayColor()
    }
    else {
      loginButton.enabled = true
      loginButton.backgroundColor = AppConstants.Colors.Orange
    }
  }
  
  //# MARK: - Login Action
  func buttonLoginAction(sender:UIButton!)
  {
    authenticate()
  }
  
  private func authenticate() {
    var user : User?
    var error : Error?
    
    
    (user, error) = AppAPI.Authenticate(usernametextField.text!, password: passwordtextField.text!)
    
    if (user != nil) {
      performSegueWithIdentifier("ShowEnquiryView", sender: self)
    }
    
      
    if (error != nil) {
      AppUtils.showAlert("Email & Password does not match", view: self)
    }
  }
}