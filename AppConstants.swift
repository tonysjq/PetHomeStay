//
//  Constants.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 19/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

/**
  * Utility Struct holding Constants used through the whole app.
  */
struct AppConstants {
  
  
  //#MARK: - Global Constants
  static let DEBUG = true
  
  //#MARK: - Colors
  struct Colors {
    static let Orange = UIColor(red: 240/255, green: 130/255, blue: 108/255, alpha: 1)
    static let Green_Success = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1)
    static let Green_light = UIColor(red: 59/255, green: 204/255, blue: 174/255, alpha: 1)
    static let Gray_light = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
  }
  
  static let CloudinaryURL = "cloudinary://375647286596578:cAwaClv2ZD27EOWNCQaMOjdSCWs@jddelgadov"
  
  private static let COLOR_GREEN_SUCCESS_NEW = UIColor(red: 58, green: 171/255, blue: 142/255, alpha: 1)
  
  //#MARK: - NSUserDefault Keys
  static let NAME = "name"
  
  //#MARK: - SEGUES
  struct Segues {
    static let ShowPetDetailsView = "ShowPetDetailsView"
    static let ShowEnquiryView = "ShowEnquiryView"
    static let ShowSignupView = "ShowSignupView"
  }
}

