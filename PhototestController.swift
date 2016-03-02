//
//  PhototestController.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/9/22.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit
@IBDesignable
class PhototestController: UIViewController,UIAlertViewDelegate, UIPopoverControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  @IBOutlet var chooseTableview: UITableView!

  @IBOutlet var petImage: UIImageView!
  
  @IBAction func btnPhotoAlbum(sender: AnyObject) {
    let alert:UIAlertController=UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    let cameraAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default)
      {
        UIAlertAction in
        self.openCamera()
        
    }
    let gallaryAction = UIAlertAction(title: "Choose Existing", style: UIAlertActionStyle.Default)
      {
        UIAlertAction in self.openGallary()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
      {
        UIAlertAction in
        
    }
    // Add the actions
    alert.addAction(cameraAction)
    alert.addAction(gallaryAction)
    alert.addAction(cancelAction)
    
    // Present the actionsheet
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone
    {
      self.presentViewController(alert, animated: true, completion: nil)
    }
    
  }
  
  
  
  var picker:UIImagePickerController?=UIImagePickerController()
  var popover:UIPopoverController?=nil
  
 
  func openCamera()
  {
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
    {
      // Check if the device supports the use of a camera
      picker!.sourceType = UIImagePickerControllerSourceType.Camera
      self .presentViewController(picker!, animated: true, completion: nil)
    }
    else
    {
      let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
        alert.dismissViewControllerAnimated(true, completion: nil)
      }))
      self.presentViewController(alert, animated: true, completion: nil)
      
      
      //openGallary()
    }
  }
  
  func openGallary()
  {
    picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone
    {
      self.presentViewController(picker!, animated: true, completion: nil)
    }
    
  }
  
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      self.petImage.contentMode = .ScaleToFill
      self.petImage.image = pickedImage
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController)
  {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  override func viewDidLoad() {
   
    picker?.delegate = self
    
     super.viewDidLoad()
    
    petImage.layer.borderWidth = 1
    petImage.layer.masksToBounds = false
    petImage.layer.borderColor = UIColor.blackColor().CGColor
    petImage.layer.cornerRadius = 35
    petImage.clipsToBounds = true
   
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}