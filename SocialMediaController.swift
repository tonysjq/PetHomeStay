//
//  SocialMediaController.swift
//  PetHomeStay
//
//  Created by Siti Nur Aini Zahari on 13/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import FBSDKShareKit

class SocialMediaController : FacebookLoginViewController, UIAlertViewDelegate, UIPopoverControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, CLUploaderDelegate{
  
  @IBOutlet var menuButton : UIBarButtonItem!
  @IBOutlet var photoUpdate: UIImageView!
  @IBOutlet var fbLogo: UIImageView!
  @IBOutlet var sharePhoto: UIButton!
  @IBOutlet var photosCaption: UITextField!
  
  var pickedImageWithNoWatermark : UIImage!
  var Cloudinary:CLCloudinary!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    picker?.delegate = self
    photosCaption.delegate = self
    
    if (FBSDKAccessToken.currentAccessToken() != nil)
    {
      print("Logged in FB")
      facebookButton.hidden = true
    } else {
      print("Not Logged in FB")
    }
    
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("uploadPic:"))
    photoUpdate.addGestureRecognizer(tapRecognizer)
  }
  
  
  
  //#MARK: - Photos, Camera and Gallery
  func uploadPic(sender: AnyObject) {
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    let cameraAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default) {
      UIAlertAction in self.openCamera()
    }
    
    let gallaryAction = UIAlertAction(title: "Choose Existing", style: UIAlertActionStyle.Default) {
      UIAlertAction in self.openGallery()
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
      UIAlertAction in
    }
    
    // Add the actions
    alert.addAction(cameraAction)
    alert.addAction(gallaryAction)
    alert.addAction(cancelAction)
    
    // Present the actionsheet
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  override func userHasLoggedIn() {
    print("METHOD OVERRIDEN FROM SOCIAL MEDIA CONTROLLER")
    facebookButton.hidden = true
  }
  
  var picker:UIImagePickerController?=UIImagePickerController()
  var popover:UIPopoverController?=nil
  
  
  func openCamera() {
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
      // Check if the device supports the use of a camera
      picker!.sourceType = UIImagePickerControllerSourceType.Camera
      self .presentViewController(picker!, animated: true, completion: nil)
    }
    else {
      let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
        alert.dismissViewControllerAnimated(true, completion: nil)
      }))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  func openGallery()
  {
    picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone
    {
      self.presentViewController(picker!, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      pickedImageWithNoWatermark = pickedImage
      
      self.photoUpdate.contentMode = .ScaleAspectFit
    
      self.photoUpdate.image = AppImagesPool.setWatermarkIntoImage(pickedImage)
      
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController)
  {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func ShareToFacebook(){
    if (pickedImageWithNoWatermark == nil){
      let title = "PetHomeStay\n "
      
      let alert = UIAlertController(
        title: title,
        message: "No photo selected",
        preferredStyle: .Alert)
      
      let action = UIAlertAction(
        title: "Close this pop-up",
        style: .Default,
        handler: nil)
      
      alert.addAction(action)
      presentViewController(alert, animated: true, completion: nil)
      return
    }
    
    if (FBSDKAccessToken.currentAccessToken() != nil)
    {
      //Should push to cloudinary
      
        Cloudinary = CLCloudinary(url: AppConstants.CloudinaryURL)
      
        let uploader:CLUploader = CLUploader(Cloudinary, delegate: self)
        uploader.upload(UIImageJPEGRepresentation(pickedImageWithNoWatermark, 0.8), options: ["format":"jpg"], withCompletion: { (succesfullResult: [NSObject : AnyObject]!, errorResult:String!, code:Int, context:AnyObject!) -> Void in
        print("PPrint:  ")
        print(succesfullResult["public_id"])
        }, andProgress: { (p1:Int, p2:Int, p3:Int, p4:AnyObject!) -> Void in
          
      })
      
      let pickedImage = self.photoUpdate.image
      var caption: String!
      caption = photosCaption.text
      AppSocialMedia.SharePhotoToFB(pickedImage!, photoCaption: caption)
    
      let title = "PetHomeStay\n "
    
      let alert = UIAlertController(
        title: title,
        message: "This photo has been shared in your Facebook profile",
        preferredStyle: .Alert)
    
      let action = UIAlertAction(
        title: "Close this pop-up",
        style: .Default,
        handler: nil)
    
    alert.addAction(action)
    presentViewController(alert, animated: true, completion: nil)
  } else {
      print("Not Logged in FB")
      let title = "PetHomeStay\n "
  
      let alert = UIAlertController(
        title: title,
        message: "Please log in to your Facebook profile",
        preferredStyle: .Alert)
  
      let action = UIAlertAction(
        title: "Close this pop-up",
        style: .Default,
        handler: nil)
  
      alert.addAction(action)
      presentViewController(alert, animated: true, completion: nil)
  }
 }
}