//
//  MyPetViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/9/30.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.

import UIKit

/**
  * UIViewController for Pets.
  */
class MyPetViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var MyPetNameArray = [Pet]()
  
  @IBOutlet var menuButton : UIBarButtonItem!
  @IBOutlet var petsTableView: UITableView!
  
  @IBOutlet var loadingIndicator: UIActivityIndicatorView!
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
      self.petsTableView.reloadData()
    }
    
    self.loadingIndicator.startAnimating()
    
    self.petsTableView.delegate = self
    self.petsTableView.dataSource = self
    
    let request = AppAPI.getPetsRequest("a74196e18eff04020761")
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
      //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
      var pets : [Pet]? = nil
      var error : Error? = nil
      
      let result = JSON(data:data!)
      
      let petsJson = result["pets"]
      
      if petsJson != nil
      {
        pets = JsonObjectFactory.parsePets(petsJson)
      }
      else {
        error = JsonObjectFactory.parseError(result["error"])
      }
      
      if error != nil {
        dispatch_async(dispatch_get_main_queue(), {
          AppUtils.showAlert(error!.messages[0], view: self)
        })
      }
      
      if (pets != nil) {
        self.MyPetNameArray = pets!
        
        
        dispatch_async(dispatch_get_main_queue(), {
          self.petsTableView.reloadData()
          self.loadingIndicator.stopAnimating()
          self.loadingIndicator.hidden = true
        })
      }
    })

  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Menu Handling
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
      self.petsTableView.reloadData()
    }
    
    self.loadingIndicator.startAnimating()
    
    self.petsTableView.delegate = self
    self.petsTableView.dataSource = self
    
    let request = AppAPI.getPetsRequest("a74196e18eff04020761")
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
      //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
      var pets : [Pet]? = nil
      var error : Error? = nil
      
      let result = JSON(data:data!)
      
      let petsJson = result["pets"]
      
      if petsJson != nil
      {
        pets = JsonObjectFactory.parsePets(petsJson)
      }
      else {
        error = JsonObjectFactory.parseError(result["error"])
      }
      
      if error != nil {
        dispatch_async(dispatch_get_main_queue(), {
          AppUtils.showAlert(error!.messages[0], view: self)
        })
      }
      
      if (pets != nil) {
        self.MyPetNameArray = pets!
      
        
        dispatch_async(dispatch_get_main_queue(), {
          self.petsTableView.reloadData()
          self.loadingIndicator.stopAnimating()
          self.loadingIndicator.hidden = true
        })
      }
    })
  
    self.petsTableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MyPetNameArray.count
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
    forRowAtIndexPath indexPath: NSIndexPath) {
      
    if (indexPath.row % 2 == 0) {
      cell.backgroundColor = UIColor.whiteColor()
    }
    else {
      cell.backgroundColor = AppConstants.Colors.Gray_light
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("OpenEditPetWebView", sender: tableView)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.destinationViewController is EditPetInWebViewController) {
      let destination = segue.destinationViewController as! EditPetInWebViewController
      
      let indexPath = petsTableView.indexPathForSelectedRow
      destination.petId = MyPetNameArray[indexPath!.row].id!
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MyPetListCell", forIndexPath: indexPath) as! MyPetListCell
    
    let pet = self.MyPetNameArray[indexPath.row]
    
    cell.petNameLabel.text = pet.name
    if pet.breed == nil {
      
      if (pet.type == nil) {
        //DO NOTHING
      }
      else {
        cell.petBreedLabel.text = (pet.type?.description)!
      }
    }
    else {
      cell.petBreedLabel.text = "Breed: " + pet.breed!
    }
    
    cell.myPetImage.image = AppImages.DogProfile
    
    if let petImageID = pet.image?.ID {
      print("Row: \(indexPath.row)")
      print("Image ID: " + petImageID)
      if let img = AppImagesPool.imageCache[petImageID] {
        cell.myPetImage.image = img
      }
      else {
        
        let request = AppImagesPool.getImageURLRequest(petImageID)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
          if error == nil {
            // Convert the downloaded data in to a UIImage object
            let image = UIImage(data: data!)
            // Store the image in to our cache
            AppImagesPool.imageCache[petImageID] = image
            
            // Update the cell
            dispatch_async(dispatch_get_main_queue(), {
              if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                if cellToUpdate is MyPetListCell {
                  let myCell = cellToUpdate as! MyPetListCell
                  myCell.myPetImage.image = image;
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
    
    return cell
  }
}
