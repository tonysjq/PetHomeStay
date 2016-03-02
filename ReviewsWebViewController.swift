//
//  ReviewsWebViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/21.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class ReviewsWebViewController: UIViewController {

  
  @IBOutlet var menuButton: UIBarButtonItem!
  @IBOutlet weak var reviewsWebView: UIWebView!
  
  var URLPath = "https://pethomestay-staging.herokuapp.com/launch/a74196e18eff04020761?path=/guest/feedbacks"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    let requestURL = NSURL(string:URLPath)
    let request = NSURLRequest(URL: requestURL!)
    
    reviewsWebView.loadRequest(request)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
