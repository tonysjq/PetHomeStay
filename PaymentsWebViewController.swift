//
//  PaymentsWebViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/21.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class PaymentsWebViewController: UIViewController {

 
  @IBOutlet weak var paymentWebView: UIWebView!
  
  var URLPath = "https://pethomestay-staging.herokuapp.com/launch/a74196e18eff04020761?path=/host/account/new"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let requestURL = NSURL(string:URLPath)
    
    let request = NSURLRequest(URL: requestURL!)
    
    paymentWebView.loadRequest(request)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
    
    
  }
}
