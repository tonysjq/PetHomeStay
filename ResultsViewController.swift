//
//  HostListViewController.swift
//  PetHomeStay
//
//  Created by Tony Qian on 18/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit
import MessageUI

/**
  * Results View Controller holding the API Call, containers, Loading Indicator and so on.
  */
class ResultsViewController: UIViewController, UISearchBarDelegate, MFMessageComposeViewControllerDelegate{
  
  //# MARK: UI Components Mapping
  @IBOutlet var mapButton: UIImageView!
  @IBOutlet var searchBar: UISearchBar!
  
  @IBOutlet var pickupLabel: UILabel!
  @IBOutlet var dropoffLabel: UILabel!
  @IBOutlet var loadingIndicator: UIActivityIndicatorView!
  
  //Containers
  @IBOutlet var noResultsContainer: UIView!
  @IBOutlet var tableViewContainer: UIView!
  @IBOutlet var mapViewContainer: UIView!
  
  @IBOutlet var glassPane: UIVisualEffectView!
  
  @IBOutlet var pickupCalendar: FSCalendar!
  @IBOutlet var dropoffCalendar: FSCalendar!
  var postcode : String?
  
  var showingTableView = true
  var notearlythandate:NSDate!
  
  var homestays : [Homestay]?
  var resultsTableViewController : ResultsTableViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.navigationController?.navigationBar.hidden = true
    
    notearlythandate=dropoffCalendar.today
    self.dropoffCalendar.frame=CGRect(x: 20, y: 100, width: 300, height: 300)
    self.pickupCalendar.frame=CGRect(x: 40, y: 100, width: 300, height: 300)
    dropoffCalendar.tag=1
    pickupCalendar.tag=2
    self.dropoffCalendar.appearance.headerMinimumDissolvedAlpha = 0.0
    self.pickupCalendar.appearance.headerMinimumDissolvedAlpha = 0.0
    self.dropoffCalendar.hidden=true
    self.pickupCalendar.hidden=true
    self.dropoffCalendar.alpha=0
    self.pickupCalendar.alpha=0
    
    self.searchBar.text = postcode
    self.searchBar.layer.borderWidth = 1
    self.searchBar.layer.borderColor = AppConstants.Colors.Orange.CGColor
    self.searchBar.delegate = self
    self.mapViewContainer.hidden = true
    self.tableViewContainer.hidden = false
    self.noResultsContainer.hidden = true
    
    self.pickupLabel.userInteractionEnabled = true
    self.dropoffLabel.userInteractionEnabled = true
    self.mapButton.userInteractionEnabled = true
    //now you need a tap gesture recognizer
    //note that target and action point to what happens when the action is recognized.
    let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
    let tapRecognizer2 = UITapGestureRecognizer(target: self, action: Selector("dropoffTapped:"))
    let tapRecognizer3 = UITapGestureRecognizer(target: self, action: Selector("pickupTapped:"))
    let tapRecognizer4 = UITapGestureRecognizer(target: self, action: Selector("hostTapped:"))
    //Add the recognizer to your view.
    mapButton.addGestureRecognizer(tapRecognizer)
    dropoffLabel.addGestureRecognizer(tapRecognizer2)
    pickupLabel.addGestureRecognizer(tapRecognizer3)

    //Get Results
    getResults()
  }
  
  func getResults() {
    self.glassPane.hidden = false
    self.loadingIndicator.hidden = false
    self.loadingIndicator.startAnimating()
    
    NSURLConnection.sendAsynchronousRequest(AppAPI.getHomestays(postcode!, latitude: nil, longitude: nil), queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
      //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
      
      //Convert JSON to object
      let results = JSON(data :data!)["homestays"]
      print("JSON LOADED")
      
      self.homestays = [Homestay]()
      
      print("Parsing JSON into Objects")
      for (_, value) in results {
        print("Parsing Homestay")
        self.homestays!.append(Homestay(homestay:value))
      }

      dispatch_async(dispatch_get_main_queue(), {
        for childController in self.childViewControllers {
          if (childController is ResultsTableViewController) {
            let resultsTableView = childController as! ResultsTableViewController
            self.resultsTableViewController = resultsTableView
            
            resultsTableView.homestays = self.homestays!
            resultsTableView.resultsViewController = self
            resultsTableView.refreshData()
          }
          else if (childController is ResultsMapViewController) {
            let resultsMapView = childController as! ResultsMapViewController
            resultsMapView.homestays = self.homestays!
            resultsMapView.refreshData()
          }
        }
        
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.hidden = true
        
        self.glassPane.hidden = true
        
        if (self.homestays!.isEmpty) {
          self.noResultsContainer.hidden = false
          self.mapViewContainer.hidden = true
          self.tableViewContainer.hidden = true
        }
        else {
          self.noResultsContainer.hidden = true
        }
      })
    })
  }

  func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
    if (showingTableView) {
      mapButton.image = UIImage(named: "GPS")
      tableViewContainer.hidden = false
      mapViewContainer.hidden = true
    }
    else {
      mapButton.image = UIImage(named: "MenuWhite")
      tableViewContainer.hidden = true
      mapViewContainer.hidden = false
    }
    showingTableView = !showingTableView
  }
  
  
  func dropoffTapped(gestureRecognizer: UITapGestureRecognizer){
    self.dropoffCalendar.hidden=false
    UIView.animateWithDuration(0.5,animations:{()->Void in
      self.dropoffCalendar.alpha=1.0})
    self.pickupLabel.userInteractionEnabled = false
  }
  
  func pickupTapped(gestureRecognizer: UITapGestureRecognizer){
     self.pickupCalendar.hidden=false
    UIView.animateWithDuration(0.5,animations:{()->Void in
      self.pickupCalendar.alpha=1.0})
   //Prevent dropoffLabel been select
    self.dropoffLabel.userInteractionEnabled = false}
  
  
  
  func hostTapped(gestureRecognizer: UITapGestureRecognizer)
  {
    let params = [ "referringUsername": "Bob",
      "referringUserId": "1234" ]
    
    // ... insert code to start the spinner of your choice here ...
    
    Branch.getInstance().getShortURLWithParams(params, andChannel: "SMS", andFeature: "Referral", andCallback: { (url: String!, error: NSError!) -> Void in
      if (error == nil) {
        if MFMessageComposeViewController.canSendText() {
          let messageComposer = MFMessageComposeViewController()
          messageComposer.body = String(format: "You should definitely take a look at MyApp -- use my invite code to get free brownie points: %@", url)
          messageComposer.messageComposeDelegate = self
          self.presentViewController(messageComposer, animated: true, completion:{(Bool) in
            // ... insert code to stop the spinner here (be sure to do so on the main thread) ...
          })
        } else {
          // ... insert code to stop the spinner here (be sure to do so on the main thread) ...
          let alert = UIAlertController(title: "Error", message: "Your device does not allow sending SMS or iMessages.", preferredStyle: UIAlertControllerStyle.Alert)
          alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
          self.presentViewController(alert, animated: true, completion: nil)
        }
      }
    })
  
  }
  
  func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
  
    let dateString = AppUtils.dateToClientFormat(date)
    print(dateString) //prints out 10:12
    if calendar.tag==1 {
      self.dropoffLabel.text=dateString
      UIView.animateWithDuration(0.5,animations:{()->Void in
        self.dropoffCalendar.alpha=0.0})
      dropoffCalendar.hidden=true
      self.pickupLabel.userInteractionEnabled = true
      let tapRecognizer3 = UITapGestureRecognizer(target: self, action: Selector("pickupTapped:"))
      self.pickupLabel.addGestureRecognizer(tapRecognizer3)
      
    }
    else {
      self.pickupLabel.text=dateString
      self.dropoffLabel.userInteractionEnabled = true
      let tapRecognizer2 = UITapGestureRecognizer(target: self, action: Selector("dropoffTapped:"))
      self.dropoffLabel.addGestureRecognizer(tapRecognizer2)
      UIView.animateWithDuration(0.5,animations:{()->Void in
        self.pickupCalendar.alpha=0.0})
       pickupCalendar.hidden=true
    }
  }
  
  func calendar(calendar: FSCalendar!, shouldSelectDate date: NSDate!) -> Bool {
    if calendar.tag==1 {
      if date<calendar.today {
        return false
      }
      else {
        notearlythandate=date
        return true
      }
    }
    else {
      if date<notearlythandate {
        return false
      }
      else {
        return true
      }
    }
  }
  
  
  
  func searchBarSearchButtonClicked( searchBar: UISearchBar) {
    postcode = searchBar.text
    searchBar.resignFirstResponder()
    
    getResults()
  }
  
  func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
    if (segue.destinationViewController is HostProfileViewController) {
      let MyHostProfileViewController = segue.destinationViewController as! HostProfileViewController
      let row = resultsTableViewController!.tableView.indexPathForSelectedRow?.row
      
      /*
      if (row == 0) {
        if (sender is UIScrollView) {
          let view = sender as! UIScrollView
        
          row = view.tag
        }
      }
      */
      
      MyHostProfileViewController.homestay = homestays![row!]
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.hidden = true
    self.tabBarController?.tabBar.hidden = false
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
