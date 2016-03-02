//
//  ReviewController.swift
//  DynamicCell
//
//  Created by Siti Nur Aini Zahari on 10/09/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit

class ReviewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var dynamicTBV: UITableView!
  
  //var textarray: NSMutableArray! = NSMutableArray()
  var textarray = ["Learn from yesterday asdasd asdasd asdasd asd asdasdadda asdasd asdasd a a adas dsadsadas asdsadsad asdasdsad asdasd assadsad asdasd asd our problems  asdasd asdasd asdasd asdasdasd asdasdas asdasd asdasd asdasd asdasdwith the same thinking our problems with the same thinking our problems with the same thinking our problems with the same thinking.","We cannot solve our problems with the same thinking we used when we created them. our problems with the same thinking we used when we created them. our problems with the same thinking we used when we created them. our problems with the same thinking we used when we created them.","When you are courting a nice girl an hour seems like a second. When you sit on a red-hot cinder a second seems like an hour. That's relativity.","To raise new questions, new possibilities, to regard old problems from a new angle, requires creative imagination and marks real advance in science.","Our task must be to free ourselves by widening our circle of compassion to embrace all living creatures and the whole of nature and its beauty.","", "Artline200", "Learn from yesterday our problems with the same thinking our problems with the same thinking our problems with the same thinking our problems with the same thinking. We cannot solve our problems with the same thinking we used when we created them. When you are courting a nice girl an hour seems like a second. When you sit on a red-hot cinder a second seems like an hour. That's relativity, man ewrewrw rwerw erwerw."]
  
  var reviewerName = ["Jon","Joni","Jonaden","Kiddo","Elizabeth","Pirate","Orlando"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.dynamicTBV.rowHeight = UITableViewAutomaticDimension
    self.dynamicTBV.estimatedRowHeight = 1800.0
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      self.dynamicTBV.reloadData()
      self.dynamicTBV.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
    })  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.textarray.count
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = dynamicTBV.dequeueReusableCellWithIdentifier("reviewCell", forIndexPath: indexPath) as! reviewCell
    cell.Review.text = textarray[indexPath.row]
    //cell.ReviewName.text = reviewerName[indexPath.row]
    return cell
  }
  
  /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
  {
  return 150.0;//Choose your custom row height
  }*/
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

