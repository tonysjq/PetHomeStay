//
//  HostListViewController.swift
//  PetHomeStay
//
//  Created by Tony Qian on 18/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit

/**
  * Main Results Table View Controller afters searching for a Host.
  */
class ResultsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  //# MARK: UI Components Mapping
  @IBOutlet var tableView : UITableView!
  
  var homestay : Homestay?
  var resultsViewController : ResultsViewController?
  var pageImages: [Image] = []
  var pageViews: [UIImageView?] = []
  
  //Local Dictionary
  var homestays = [Homestay]()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.delegate = self
    self.tableView.dataSource = self
    
  }
  
  

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homestays.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let hostCell = tableView.dequeueReusableCellWithIdentifier("HostListCell", forIndexPath: indexPath) as! HostListCell
    
    let homestay = self.homestays[indexPath.row]
    
    hostCell.fillHostListCell(homestay)
    
    //Profile Image!
    hostCell.profilePhoto.image = AppImages.Profile
    
    if let profilePhotoID = homestay.profilePhotoID {
      print("Row: \(indexPath.row)")
      print("Image ID: " + profilePhotoID)
      if let img = AppImagesPool.imageCache[profilePhotoID] {
        hostCell.profilePhoto.image = img
      }
      else {
        
        let request = AppImagesPool.getImageURLRequest(profilePhotoID)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
          if error == nil {
            // Convert the downloaded data in to a UIImage object
            let image = UIImage(data: data!)
            // Store the image in to our cache
            AppImagesPool.imageCache[profilePhotoID] = image
            
            // Update the cell
            dispatch_async(dispatch_get_main_queue(), {
              if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                if cellToUpdate is HostListCell {
                  let myCell = cellToUpdate as! HostListCell
                  myCell.profilePhoto.image = image;
                }
              }
            })
          }
          else {
            print("Error: \(error!.localizedDescription)")
          }
        })
      }
    }
    
    //let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("scrollViewTapped:"))
    //hostCell.Scroller.addGestureRecognizer(tapRecognizer)
    //hostCell.Scroller.tag = indexPath.row
    
    //hostCell.tag = indexPath.row
    
    return hostCell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    resultsViewController?.performSegueWithIdentifier("HostDetails", sender: tableView)
    UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 270
  }
  
  func refreshData() {
    self.tableView.reloadData()
  }
  
  func scrollViewTapped(gestureRecognizer: UITapGestureRecognizer)
  {
    resultsViewController?.performSegueWithIdentifier("HostDetails", sender: gestureRecognizer.view)
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
