//
//  EditPetInWebViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/14.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class EditPetInWebViewController: UIViewController {
  
  @IBOutlet weak var editPetWebView: UIWebView!
  
  var URLPath = "https://pethomestay-staging.herokuapp.com/launch/a74196e18eff04020761?path=/guest/pets/"
  var petId : Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    URLPath += "\(petId)/edit"
    
    let requestURL = NSURL(string:URLPath)
    let request = NSURLRequest(URL: requestURL!)
    
    editPetWebView.loadRequest(request)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
