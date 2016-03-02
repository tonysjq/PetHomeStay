//
//  SignupContainer.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/9/2.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class LoginContainer: UIViewController {
  
  @IBOutlet var email: UITextField!
  @IBOutlet var password: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
      //lineView is the orange line between email and password textfiled.    
    let lineView = UIView(frame: CGRectMake(0, 41, 320, 1.0))
    lineView.layer.borderWidth = 1.0
    lineView.layer.borderColor = UIColor.whiteColor().CGColor
    self.view.addSubview(lineView)
    
    email.attributedPlaceholder = NSAttributedString(string:"Email",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    password.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}