//
//  InboxWebViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/14.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class InboxWebViewController: UIViewController {

 
  @IBOutlet weak var inboxWebView: UIWebView!
  
  var URLPath = "https://pethomestay-staging.herokuapp.com/launch/a74196e18eff04020761?path=/guest/messages"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let requestURL = NSURL(string:URLPath)
    
    let request = NSURLRequest(URL: requestURL!)
    
    inboxWebView.loadRequest(request)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
    
    
  }
}
