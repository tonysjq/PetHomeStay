//
//  AppImagesPool.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 1/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

struct AppImages {
  static let Profile = UIImage(named: "DefaultProfile")
  static let ReviewDefaultProfile = UIImage(named: "DefaultProfile")
  static let MascotLight = UIImage(named: "PetHomeStayMascotLight")
  static let PoliceCheck = UIImage(named: "PoliceCheck")
  static let EmergencyTransport = UIImage(named: "Ambulance")
  static let ProfileLandscape = UIImage(named: "LandscapeProfile")
  static let ServiceLocal = UIImage(named: "ServiceLocal")
  static let ServiceRemote = UIImage(named: "ServiceRemote")
  static let ServiceDelivery = UIImage(named: "ServiceDelivery")
  static let ServiceGrooming = UIImage(named: "ServiceGrooming")
  static let ServiceWalking = UIImage(named: "ServiceWalking")
  static let DogProfile = UIImage(named: "DogProfile")
  static let PHSLogo = UIImage(named: "PetHomeStay")
  static let PHSLogoWatermark = UIImage(named: "PetHomestayLogoWatermark")
  
  struct PetDetails {
    static let PetTypeCat = UIImage(named: "PetTypeCat")
    static let PetTypeCatOrange = UIImage(named: "PetTypeCatOrange")
    static let PetTypeDog = UIImage(named: "PetTypeDog")
    static let PetTypeDogOrange = UIImage(named: "PetTypeDogOrange")
    static let PetTypeOther = UIImage(named: "PetTypeOther")
    static let PetTypeOtherOrange = UIImage(named: "PetTypeOtherOrange")
    static let PetEnergyLevelLazy = UIImage(named: "PetEnergyLevelLazy")
    static let PetEnergyLevelLazyOrange = UIImage(named: "PetEnergyLevelLazyOrange")
    static let PetEnergyLevelMedium = UIImage(named: "PetEnergyLevelMedium")
    static let PetEnergyLevelMediumOrange = UIImage(named: "PetEnergyLevelMediumOrange")
    static let PetEnergyLevelHigh = UIImage(named: "PetEnergyLevelHigh")
    static let PetEnergyLevelHighOrange = UIImage(named: "PetEnergyLevelHighOrange")
    static let PetSexFemale = UIImage(named: "PetSexFemale")
    static let PetSexFemaleOrange = UIImage(named: "PetSexFemaleOrange")
    static let PetSexMale = UIImage(named: "PetSexMale")
    static let PetSexMaleOrange = UIImage(named: "PetSexMaleOrange")
    static let PetSizeSmall = UIImage(named: "PetSizeSmall")
    static let PetSizeSmallOrange = UIImage(named: "PetSizeSmallOrange")
    static let PetSizeMedium = UIImage(named: "PetSizeMedium")
    static let PetSizeMediumOrange = UIImage(named: "PetSizeMediumOrange")
    static let PetSizeLarge = UIImage(named: "PetSizeLarge")
    static let PetSizeLargeOrange = UIImage(named: "PetSizeLargeOrange")
    static let PetSizeXLarge = UIImage(named: "PetSizeXLarge")
    static let PetSizeXLargeOrange = UIImage(named: "PetSizeXLargeOrange")
    
  }
}

/**
  *  Utility class holding all methods to handle images. It has the CLoudinary 
  *  URL to download de images as well as some Watermark methods.
  */
class AppImagesPool {
  
  //Base URL for Images
  private static let IMAGES_BASE = "https://res.cloudinary.com/hxnfgf9c2/image/upload/q_70/"
  
  //Create a Dictionary of String (ID) and Image
  static var imageCache = [String:UIImage]()
  
  class func getImage(imageID: String, imageView: UIImageView, setWatermark: Bool) {
    // If this image is already cached, don't re-download
    if let img = AppImagesPool.imageCache[imageID] {
      imageView.image = img
    }
    else {
      //Download photo on other Thread.
      let request = AppImagesPool.getImageURLRequest(imageID);
      let mainQueue = NSOperationQueue.mainQueue()
      
      NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
        if error == nil {
          print("Async: IMAGE ID: " + imageID)
          
          // Convert the downloaded data in to a UIImage object
          let image = UIImage(data: data!)
          var result = image!
          
          // Set Watermark into downloaded image
          if (setWatermark) {
            result = setWatermarkIntoImage(image!)
          }
          
          // Store the image in to our cache
          AppImagesPool.imageCache[imageID] = result

          // Update the cell
          dispatch_async(dispatch_get_main_queue(), {
            print("DISPATCH: Image ID: \(imageID)")
            
            imageView.image = result
          })
        }
        else {
          print("Error: \(error!.localizedDescription)")
        }
      })
    }
  }
  
  class func setWatermarkIntoImage(myImage : UIImage) -> UIImage {
    let pickedImage = myImage
    let watermarkImage = AppImages.PHSLogo
    
    var pickedImageWidth = pickedImage.size.width
    var pickedImageHeight = pickedImage.size.height
    
    if (pickedImage.size.width > 1000 || pickedImage.size.height > 1000) {
      pickedImageWidth = pickedImage.size.width/3
      pickedImageHeight = pickedImage.size.height/3
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(pickedImageWidth, pickedImageHeight), false, 0.0)
    
    pickedImage.drawInRect(CGRect(x: 0.0, y: 0.0, width: pickedImageWidth, height: pickedImageHeight))
    
    //Calculation works for scaling watermark image to background image accordingly - Aini
    let widthOfWatermarkImage = 41.5 * (pickedImageWidth) / 100
    let heightOfWatermarkImage = widthOfWatermarkImage / 6.3
    let watermarkPadding = 5 * (pickedImageWidth) / 100
    
    watermarkImage!.drawInRect(CGRect(x: watermarkPadding, y: pickedImageHeight - heightOfWatermarkImage - watermarkPadding, width: widthOfWatermarkImage, height: heightOfWatermarkImage))
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return result
  }
  
  class func getImageURLRequest(imageID: String) -> NSURLRequest {
    return NSURLRequest(URL: getImageURL(imageID))
  }
  
  private class func getImageURL(imageID: String) -> NSURL {
    return NSURL(string: IMAGES_BASE + imageID)!
  }
}