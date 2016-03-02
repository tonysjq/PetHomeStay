//
//  ThingstodoContainer.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/10/7.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//
import UIKit

/**
  * Main UITableViewController to handle the Cards Table with the different actions, delegate.
  */
class DashboardCardsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var cardsTableview: UITableView!
  
  
  var phonenum:String!
  var dashboard : DashboardViewController? //Hold a Reference to Parent View.
  var dashboardIdentifier : EDashboardView? //Identifier of the View.
  
  var dashboardCards = [DashboardCard]() //Model of Data to be displayed.
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.cardsTableview.delegate = self
    self.cardsTableview.dataSource = self
    self.cardsTableview.separatorColor = UIColor.clearColor()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func reloadTable() {
    self.cardsTableview.reloadData()
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return  dashboardCards.count
  }
  
  func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return " "
  }
  
  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 6
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if dashboardCards[section].type.description=="Booking"
    {return dashboardCards[section].pets.count+2}
    else
    {return dashboardCards[section].pets.count*2+1}
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let row = indexPath.row as Int!
    let section = indexPath.section as Int!
    var height:CGFloat!
    
    if row < dashboardCards[section].pets.count {
      height=130
    }
    else if row == dashboardCards[section].pets.count {
      height=130
    }
    else {
      if dashboardCards[section].type == EDashboardCardType.Booking {
        height=80
      }
      else {
        height=100
      }
    }
    return height
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let row = indexPath.row as Int!
    let section = indexPath.section as Int!
    var cell:UITableViewCell!
    
    let dashboardCard = dashboardCards[section]
    
    if row < dashboardCards[section].pets.count {
      let tempCell = tableView.dequeueReusableCellWithIdentifier("petIdentifier", forIndexPath: indexPath) as! PetTableViewCell
      print(section)
      if row>0
      {
      tempCell.petdate.hidden=true
      }
      
      if (dashboardCard.type == EDashboardCardType.Booking) {
        tempCell.CellTitle.text = "Booking Received"
      }
      else {
        tempCell.CellTitle.text = "Review a Pet"
      }
      
      tempCell.petname.text=dashboardCards[section].pets[row].name
      tempCell.petdate.text=dashboardCards[section].date
      if dashboardCards[section].type == EDashboardCardType.Booking
      {
        tempCell.petdate.textColor=AppConstants.Colors.Orange
      }
      else
      {
        tempCell.petdate.textColor=UIColor.grayColor()
      }
      cell=tempCell
    }
    else if row == dashboardCards[section].pets.count {
      let tempCell  = tableView.dequeueReusableCellWithIdentifier("ownerIdentifier", forIndexPath: indexPath) as! OwnerTableViewCell
      tempCell.owner.text=dashboardCards[section].host.name
      print(dashboardCards[section].host.name)
      tempCell.ownerphoenumlabel.text=dashboardCards[section].host.phone
      tempCell.ownerphonenum.tag=Int(dashboardCards[section].host.phone)!
      tempCell.ownerphonenum.addTarget(self, action:"makeCall:", forControlEvents: UIControlEvents.TouchUpInside)
      cell=tempCell
      
    }
    else if (dashboardCards[section].type == EDashboardCardType.Booking) && (row == dashboardCards[section].pets.count+1){
      
      let tempCell = tableView.dequeueReusableCellWithIdentifier("confirmIdentifier", forIndexPath: indexPath) as! ConfirmTableViewCell
      if EDashboardView.ThingsToDo == dashboardIdentifier{
        
        tempCell.messagenumber.text=String(dashboardCards[section].messages)
        tempCell.pricelabel.text="$"+String(dashboardCards[section].price)
        
        tempCell.confirmbutton.tag=section
        tempCell.deletebutton.tag=section
        tempCell.confirmbutton.addTarget(self, action: "confirmAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        tempCell.deletebutton.addTarget(self, action: "deleteAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
      }
      if EDashboardView.Booked == dashboardIdentifier {
        tempCell.messagenumberinbandh.text=String(dashboardCards[section].messages)
        tempCell.pricelabelinbandh.text="$"+String(dashboardCards[section].price)
        
        tempCell.pricelabel.hidden=true
        tempCell.editbutton.hidden=true
        tempCell.deletebutton.hidden=true
        tempCell.messagenumber.hidden=true
        tempCell.messagebutton.hidden=true
        tempCell.confirmbutton.hidden=true
        tempCell.pricebutton.hidden=false
        tempCell.messagenumberinbandh.hidden=false
        tempCell.messagebuttoninbandh.hidden=false
        tempCell.pricelabelinbandh.hidden=false
      }
      
      if EDashboardView.History == dashboardIdentifier
      {
        tempCell.messagenumberinbandh.text=String(dashboardCards[section].messages)
        tempCell.pricelabelinbandh.text="$"+String(dashboardCards[section].price)
        tempCell.pricelabel.hidden=true
        tempCell.editbutton.hidden=true
        tempCell.deletebutton.hidden=true
        tempCell.messagenumber.hidden=true
        tempCell.messagebutton.hidden=true
        tempCell.confirmbutton.hidden=true
        tempCell.pricebutton.hidden=false
        tempCell.messagenumberinbandh.hidden=false
        tempCell.messagebuttoninbandh.hidden=false
        tempCell.pricelabelinbandh.hidden=false
        
      }
      
      let additionalSeparator = UIView(frame: CGRectMake(0, tempCell.frame.size.height-3, tempCell.frame.size.width,3))
      additionalSeparator.backgroundColor = UIColor.grayColor()
      tempCell.addSubview(additionalSeparator)
      
      cell=tempCell
    }
    else {
      
      let tempCell = tableView.dequeueReusableCellWithIdentifier("howisIdentifier", forIndexPath: indexPath) as! ReviewTableViewCell
      if EDashboardView.ThingsToDo == dashboardIdentifier{
        let num=row-1-dashboardCards[section].pets.count
        /* if num+1<dashboardCards[section].pets.count
        {tempCell.ratingview.addTarget(self, action: "didChangeValue:", forControlEvents: UIControlEvents.ValueChanged)}*/
        
        tempCell.ratingview.tag=section
        tempCell.ratingview.addTarget(self, action: "didChangeValueandmove:", forControlEvents: UIControlEvents.ValueChanged)
        tempCell.reviewlabel.text="How is "+dashboardCards[section].pets[num].name+"?"
        tempCell.ratingview.value=dashboardCards[section].rating
        
        let additionalSeparator = UIView(frame: CGRectMake(0, tempCell.frame.size.height-3, tempCell.frame.size.width,3))
        additionalSeparator.backgroundColor = UIColor.grayColor()
        tempCell.addSubview(additionalSeparator)
        
      }
      else
      {  let num=row-1-dashboardCards[section].pets.count
        tempCell.reviewlabel.text="How is "+dashboardCards[section].pets[num].name+"?"
        tempCell.ratingview.value=dashboardCards[section].rating
        tempCell.ratingview.userInteractionEnabled=false
        
      }
      cell=tempCell
    }
    return cell
  }
  
  func deleteAction(sender: UIButton!) {
    // Create the alert controller
    let alertController = UIAlertController(title: "PerHomeStay", message: "Are you sure to delete this booking?", preferredStyle: .Alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
      UIAlertAction in
      NSLog("OK Pressed")

    let cell = sender.superview?.superview as! UITableViewCell
    let indexPath = self.cardsTableview.indexPathForCell(cell)
    
    let card = self.dashboardCards.removeAtIndex(indexPath!.section)
    
    //Update the model.
    DashboardDummyData.thingsToDoCards.removeAtIndex(indexPath!.section)
    
    self.cardsTableview.deleteSections(NSIndexSet(index:indexPath!.section), withRowAnimation:UITableViewRowAnimation.Fade)
    
      self.dashboard!.cardDeleteFromThingsToDo(card)}
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
      UIAlertAction in
      NSLog("Cancel Pressed")
      
    }
    
    // Add the actions
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    
    // Present the controller
    self.presentViewController(alertController, animated: true, completion: nil)

    
  }
  
  func confirmAction(sender: UIButton!) {
    // Create the alert controller
    let alertController = UIAlertController(title: "PerHomeStay", message: "Are you sure to confirm this booking?", preferredStyle: .Alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
      UIAlertAction in
      NSLog("OK Pressed")
      let cell = sender.superview?.superview as! UITableViewCell
      let indexPath = self.cardsTableview.indexPathForCell(cell)
      
      let card = self.dashboardCards.removeAtIndex(indexPath!.section)
      
      //Update the model.
      DashboardDummyData.thingsToDoCards.removeAtIndex(indexPath!.section)
      
      self.cardsTableview.deleteSections(NSIndexSet(index:indexPath!.section), withRowAnimation:UITableViewRowAnimation.Fade)
      self.dashboard!.cardConfirmedFromThingsToDo(card)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
      UIAlertAction in
      NSLog("Cancel Pressed")

    }
    
    // Add the actions
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    
    // Present the controller
    self.presentViewController(alertController, animated: true, completion: nil)
      }
  
  func makeCall(sender: UIButton!) {
    
    let phonenum="0"+String(sender.tag)
    print(phonenum)
    if let url = NSURL(string: "tel://\(phonenum)") {
      UIApplication.sharedApplication().openURL(url)
    }
  }
  
  func didChangeValueandmove(rating:HCSStarRatingView) {
    print(rating.value)
    let cell = rating.superview?.superview as! UITableViewCell
    let indexPath = self.cardsTableview.indexPathForCell(cell)
    dashboardCards[indexPath!.section].rating=rating.value
    
    let card = self.dashboardCards[indexPath!.section]
    self.dashboardCards.removeAtIndex(indexPath!.section)
    
    //Update the model.
    DashboardDummyData.thingsToDoCards.removeAtIndex(indexPath!.section)
    
    cardsTableview.deleteSections(NSIndexSet(index:indexPath!.section), withRowAnimation:UITableViewRowAnimation.Fade)
    dashboard!.cardDeleteFromThingsToDo(card)
  }
}



class IdentifiedButton: UIButton {
  var buttonIdentifier: String?
}

