//
//  MyServiceWebViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/21.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class MyServiceWebViewController: UIViewController {

  @IBOutlet weak var myServiceWebView: UIWebView!
  
  @IBOutlet weak var menuButton: UIBarButtonItem!
  
  var URLPath = "https://pethomestay-staging.herokuapp.com/launch/a74196e18eff04020761?path=/host/homestay/edit"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    let requestURL = NSURL(string:URLPath)
    
    let request = NSURLRequest(URL: requestURL!)
    
    myServiceWebView.loadRequest(request)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
    
    
  }

}
