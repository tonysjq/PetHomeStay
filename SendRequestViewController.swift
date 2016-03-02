//
//  SendRequestViewController.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/9/17.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class SendRequestViewController: UIViewController {

  @IBOutlet var dropoffButton: UIButton!

  @IBOutlet var submitenquiryButton: UIButton!
  @IBOutlet var pickupButton: UIButton!

  var notearlythandate:NSDate!
  var minimumdate:NSDate!
  @IBOutlet var dropoffCalendar: FSCalendar!
  
  @IBOutlet var pickupCalendar: FSCalendar!
 
  @IBAction func submitEnquiry(sender: UIButton) {
    let alert = UIAlertController(title: "PetHomeStay", message: "Submitting Enquiry", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in self.navigationController?.popViewControllerAnimated(true)}))
    self.presentViewController(alert, animated: true, completion: nil)

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    AppData.EnquiryProcess = 0
    
    submitenquiryButton.backgroundColor=AppConstants.Colors.Green_Success
    dropoffCalendar.tag=1
    pickupCalendar.tag=2
    dropoffCalendar.frame=CGRect(x: 0, y: 0, width: 300, height: 350)
    dropoffCalendar.hidden=true
    dropoffCalendar.alpha=0
    dropoffButton.addTarget(self, action: "dropoffAction:", forControlEvents: UIControlEvents.TouchUpInside)
    dropoffCalendar.appearance.headerMinimumDissolvedAlpha = 0.0;
    
    pickupCalendar.frame=CGRect(x: 0, y: 0, width: 300, height: 350)
    pickupCalendar.hidden=true
    //pickupCalendar.alpha=0
    pickupButton.addTarget(self, action: "pickupAction:", forControlEvents: UIControlEvents.TouchUpInside)
    pickupCalendar.appearance.headerMinimumDissolvedAlpha = 0.0;    // Do any additional setup after loading the view.
    
    notearlythandate=dropoffCalendar.today
    
    }

  
  func dropoffAction(sender:UIButton!)
  {
  pickupCalendar.hidden=true
  dropoffCalendar.hidden=false
  UIView.animateWithDuration(0.5,animations:{()->Void in
      self.dropoffCalendar.alpha=1.0})
  pickupButton.enabled=false
  
  }
  
  func pickupAction(sender:UIButton!)
  {
    dropoffCalendar.hidden=true
    pickupCalendar.hidden=false
    UIView.animateWithDuration(0.5,animations:{()->Void in
      self.pickupCalendar.alpha=1.0})
    
    dropoffButton.enabled=false
    
  }
  
 func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
  let dateString = AppUtils.dateToClientFormat(date)
  print(dateString) //prints out 10:12
  if calendar.tag==1
  {self.dropoffButton.setTitle(dateString, forState: .Normal)
    UIView.animateWithDuration(0.5,animations:{()->Void in
      self.dropoffCalendar.alpha=0.0})
  pickupButton.enabled=true
  }
  else
  {self.pickupButton.setTitle(dateString, forState: .Normal)
    UIView.animateWithDuration(0.5,animations:{()->Void in
      self.pickupCalendar.alpha=0.0})
    dropoffButton.enabled=true}
   dropoffCalendar.hidden=true
   pickupCalendar.hidden=true
  }
  
  
  func calendar(calendar: FSCalendar!, shouldSelectDate date: NSDate!) -> Bool {
    
    if calendar.tag==1
    { if date<calendar.today
    {return false}
      else
      { notearlythandate=date
        return true
      }
    }
    else
    { if date<notearlythandate
    {return false}
      else
    {return true}
    }
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

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }


