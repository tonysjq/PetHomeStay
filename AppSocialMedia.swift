//
//  AppSocialMedia.swift
//  PetHomeStay
//
//  Created by Siti Nur Aini Zahari on 22/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

/**
  *  Utility Class to handle social media. Such as SharePhoto to Facebook and Branch SDK.
  */
class AppSocialMedia {
  
  class func SharePhotoToFB(myImage : UIImage, photoCaption : String) {
    let sharePhoto = FBSDKSharePhoto()
    
    var captionLink = photoCaption
    
    if(AppData.BranchURL != nil) {
      captionLink += " - Check out my profile here: " + AppData.BranchURL!
    }
    
    sharePhoto.caption = captionLink
    sharePhoto.image = myImage
    
    let content = FBSDKSharePhotoContent()
    content.photos = [sharePhoto]
    FBSDKShareAPI.shareWithContent(content, delegate: nil)
  }
  
  class func BranchShareLink(Userid: String, Username: String)
  {
    let params = [ "referringUsername": Username, "referringUserId": Userid ]
    
    Branch.getInstance().getShortURLWithParams(params, andCallback: { (url: String!, error: NSError!) -> Void in
      if (error == nil) {
        // Now we can do something with the URL...
        AppData.BranchURL = url
      }
    })
  }
}