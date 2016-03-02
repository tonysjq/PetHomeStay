//
//  ViewController.swift
//  DynamicCell
//
//  Created by Siti Nur Aini Zahari on 10/09/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit

/**
  * SAMPLE Code for a DynamicCell Table View.
  */
class DynamicTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var dynamicTBV: UITableView!
  
  //var textarray: NSMutableArray! = NSMutableArray()
  var textarray = ["Learn from yesterday ouasdasd prasd asd asdasdasdasd asfasfsa asfad gery  rt seg seg esrg erg ergersges gser ge ges rg esrg er ger ger g er gesr g erg es gesr geryfgweh fw fuwabfjaw fuhwaf eawuafew f weu few fu whfe wau fwaeefg awef ewaufwau fwaek uyh oblems with the same thinking our problems with the same thinking our problems with the same thinking our problems with the same thinking.","We cannot solve ourasd problems with the same thinking we used when we created them.","When you are courting a nice girl an hour seems like a second. When you sit on a red-hot cinder a second seems like an hour. That's relativity.","To raise new questions, new possibilities, to regard old problems from a new angle, requires creative imagination and marks real advance in science.","Our task must be to free ourselves by widening our circle of compassion to embrace all living creatures and the whole of nature and its beauty.","", "Artline200"]
  
  var reviewerName = ["Jon","Joni","Jonaden","Kiddo","Elizabeth","Pirate","Orlando"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
      self.dynamicTBV.rowHeight = UITableViewAutomaticDimension
      self.dynamicTBV.estimatedRowHeight = 1800.0
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      self.dynamicTBV.reloadData()
      self.dynamicTBV.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
    })
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.textarray.count
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = dynamicTBV.dequeueReusableCellWithIdentifier("reviewCell", forIndexPath: indexPath) as! reviewCell
    cell.Review.text = textarray[indexPath.row]
    cell.ReviewName.text = reviewerName[indexPath.row]
    return cell
  }
  
 
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

