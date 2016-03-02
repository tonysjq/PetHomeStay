 
//
//  AppData.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 15/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

 /**
   * Utility class holding general util methods.
   */
class AppData {
  
  static var DogBreeds = [DogBreed]()
  static var DeviceToken : NSData?
  static var BranchURL : String?
  
  static var UserToken : String?
  
  
  //0 Its ok
  //1 Go to Pet Details
  //2 Go to Send Enquiry
  static var EnquiryProcess = 0
  
  class func loadBasicData() {
    NSURLConnection.sendAsynchronousRequest(AppAPI.getBasicAppDataRequest(), queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
      //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil 
      //#TODO: - JDDV Implement Errors of Asynchronous Calls
      
      print("JSON: DATA LOADED")
      
      //Convert JSON to object
      if (data != nil) {
        let dataResult = JSON(data: data!)["data"]
      
        //BREEDS
        print("JSON: Parsing Breeds")
        let breedsArray = dataResult["pet"]["breeds"]
      
        for (_, value) in breedsArray {
          self.DogBreeds.append(DogBreed(breedName: value.stringValue))
        }
        print("JSON: Breeds Parsed: \(self.DogBreeds.count)")
      }
    })
  }
}