//
//  MyNotificationViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/9/30.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

/**
  * This is the UITableViewController for the Notifications Views.
  */
class MyNotificationViewController: UITableViewController {

  var MyNotificationArray = [Notification]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tabBarController?.tabBar.hidden = false
    
    //Load Some Hardcoded Notifications
    fillNotifications()
    
    
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MyNotificationArray.count
  }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
    forRowAtIndexPath indexPath: NSIndexPath) {
      
      if (indexPath.row % 2 == 0)
      {
        cell.backgroundColor = UIColor.whiteColor()
      }
      else
      {
        cell.backgroundColor = AppConstants.Colors.Gray_light
      }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MyNotificationCell", forIndexPath: indexPath) as! MyNotificationCell
    
    let notification = self.MyNotificationArray[indexPath.row]
    cell.fillNotificationCell(notification)
    cell.disPlayPhotosCell(notification)
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let selectedNotification = MyNotificationArray[indexPath.row]
    
    //Only perform segue for Identifier (Show Image) when a Photo is received through notifications.
    if (selectedNotification.notificationType == ENotification.PhotoReceived) {
      performSegueWithIdentifier("showImage", sender: self)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
    if (segue.destinationViewController is SaveImageViewController) {
      let newViewController = segue.destinationViewController as! SaveImageViewController
      let selectedNotification = MyNotificationArray[(tableView.indexPathForSelectedRow?.row)!]
      newViewController.imageid = selectedNotification.imageId!
    }
  }
  
  // MARK: - Table view data source
  private func fillNotifications() {
    var user = createUser(1, firstName: "Juan", lastName: "Delgado", email: "s3469216@student.rmit.edu.au", token: "qwertyuiop")
    var notification = createNotification(ENotification.EnquiryReceived, message: "Please accept my dog", date: NSDate(), sender: user)
    
    MyNotificationArray.append((notification))
    
    user = createUser(2, firstName: "Barti", lastName: "Murugesan", email: "barti.murugesan@rmit.edu.au", token: "projectmanager")
    notification = createNotification(ENotification.PhotoReceived, message: "Look at this picture I've taken from your dog.", date: removeDaysToDate(2), sender: user)
    notification.imageId = "snqrxvcxg7jaxgqerpjt"
    
    MyNotificationArray.append((notification))
    
    user = createUser(3, firstName: "Siti", lastName: "Aini", email: "s347574@student.rmit.edu.au", token: "asdfghjkl")
    notification = createNotification(ENotification.EnquiryReceived, message: "Please accept my cat", date: removeDaysToDate(5), sender: user)
    
    MyNotificationArray.append((notification))
    
    user = createUser(4, firstName: "Abdullah", lastName: "Aljohani", email: "designer@student.rmit.edu.au", token: "zxcvbnm")
    notification = createNotification(ENotification.Message, message: "Hey, it was a pleasure to meet you up. I will be happy to host your pets for the following weekend as well as for Xmass eve as we discussed already. Best Regards, Abdullah", date: removeDaysToDate(6), sender: user)
    
    MyNotificationArray.append((notification))
    
    user = createUser(5, firstName: "Dan", lastName: "Yang", email: "developer@student.rmit.edu.au", token: "12345")
    notification = createNotification(ENotification.TakePhoto, message: "Please take a photo of the pet you are hosting at the moment.", date: removeDaysToDate(10), sender: user)
    
    MyNotificationArray.append((notification))
    
    user = createUser(6, firstName: "Tony", lastName: "Qian", email: "ProInTableViews@student.rmit.edu.au", token: "tableViewPro")
    notification = createNotification(ENotification.ReviewToBeDone, message: "Please review Tom", date: removeDaysToDate(12), sender: user)
    
    MyNotificationArray.append((notification))
  }
  
  private func removeDaysToDate(numberOfDays: Int) -> NSDate {
    let today = NSDate()
    let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
      .Day,
      value: (numberOfDays * -1),
      toDate: today,
      options: NSCalendarOptions(rawValue: 0))
    
    return tomorrow!
  }
  
  private func createNotification(type: ENotification, message: String, date: NSDate, sender: User) -> Notification {
    let notification = Notification(notificationType: type, message: message, date: date, sender: sender)
    return notification
  }
  
  private func createUser(id: Int, firstName: String, lastName: String, email: String, token: String) -> User {
    let user = User(id: id, firstName: firstName, lastName: lastName, email: email, token: token)
    return user
  }
  

}
