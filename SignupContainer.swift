//
//  SignupContainer.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/9/2.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class SignupContainer: UIViewController {
  
  
  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //White Line between Email and Password
    let lineView = UIView(frame: CGRectMake(0, 111, 320, 1.0))
    lineView.layer.borderWidth = 1.0
    lineView.layer.borderColor = UIColor.whiteColor().CGColor
    self.view.addSubview(lineView)
    
    //Set the border color and width.
    firstNameTextField.layer.cornerRadius=2.0
    firstNameTextField.layer.masksToBounds=true
    firstNameTextField.layer.borderColor=UIColor.whiteColor().CGColor
    firstNameTextField.layer.borderWidth = 1.0
    
    lastNameTextField.layer.cornerRadius=2.0
    lastNameTextField.layer.masksToBounds=true
    lastNameTextField.layer.borderColor=UIColor.whiteColor().CGColor;
    lastNameTextField.layer.borderWidth = 1.0
    
    firstNameTextField.attributedPlaceholder = NSAttributedString(string:"First Name",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    lastNameTextField.attributedPlaceholder = NSAttributedString(string:"Last Name",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    emailTextField.attributedPlaceholder = NSAttributedString(string:"Email",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}