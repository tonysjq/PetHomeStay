//
//  SaveImageViewController.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/10/15.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

/**
  * View controller used to save image into the gallery or share thoughts to facebook.
  */
class SaveImageViewController: UIViewController, UITextFieldDelegate {
  
  var imageid:String!
  
  @IBOutlet var petimage: UIImageView!
  @IBOutlet var saveImageIcon: UIImageView!
  @IBOutlet var photosCaption: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    AppImagesPool.getImage(imageid,imageView:petimage, setWatermark: true)
    self.tabBarController!.tabBar.hidden = true
    
    // Do any additional setup after loading the view.
    let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("saveImageTest:"))
    saveImageIcon.addGestureRecognizer(tapRecognizer)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    photosCaption.resignFirstResponder()
    return false
  }
  
  func saveImageTest(gestureRecognizer: UITapGestureRecognizer ) {
  
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    let saveGallery = UIAlertAction(title: "Save image to Photo Gallery", style: UIAlertActionStyle.Default) {
     
      UIAlertAction in PHSPhotoAlbum.sharedInstance.saveImage(self.petimage.image!)
      let alert = UIAlertView()
      alert.title = "PetHomeStay"
      alert.message = "The Photo is saved!"
      alert.addButtonWithTitle("OK")
      alert.show()
    }
    
    let facebookShare = UIAlertAction(title: "Share To Facebook", style: UIAlertActionStyle.Default) {
      UIAlertAction in self.ShareToFacebook()
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
      UIAlertAction in
    }
    
    // Add the actions
    if (FBSDKAccessToken.currentAccessToken() != nil)
    {
      alert.addAction(saveGallery)
      alert.addAction(facebookShare)
      alert.addAction(cancelAction)
    } else {
      alert.addAction(saveGallery)
      alert.addAction(cancelAction)
    }
    
    // Present the actionsheet
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  func ShareToFacebook(){
      let pickedImage = self.petimage.image
      var caption: String!
      caption = photosCaption.text
      AppSocialMedia.SharePhotoToFB(pickedImage!, photoCaption: caption)
      print(caption)
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
  }
  
  func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
    if error == nil {
      let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
      ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      presentViewController(ac, animated: true, completion: nil)
    } else {
      let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
      ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      presentViewController(ac, animated: true, completion: nil)
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    self.tabBarController?.tabBar.hidden = false
  }
}
