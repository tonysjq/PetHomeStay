//
//  EditPasswordViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/7.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class EditPasswordViewController: UIViewController {

  @IBOutlet weak var imageOfGuest: UIImageView!
  
  @IBOutlet weak var oldPasswordText: UITextField!
  
  @IBOutlet weak var newPasswordText: UITextField!
  @IBOutlet weak var newPasswordText2: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      imageOfGuest.layer.cornerRadius = 50
      imageOfGuest.clipsToBounds = true
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
