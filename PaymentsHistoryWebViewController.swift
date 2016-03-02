//
//  PaymentsHistoryWebViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/21.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class PaymentsHistoryWebViewController: UIViewController {

 
  @IBOutlet weak var paymentHistroyWebView: UIWebView!
  
  var URLPath = "https://pethomestay-staging.herokuapp.com/launch/a74196e18eff04020761?path=/host/homestay/new"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let requestURL = NSURL(string:URLPath)
    
    let request = NSURLRequest(URL: requestURL!)
    
    paymentHistroyWebView.loadRequest(request)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
    
    
  }

}
