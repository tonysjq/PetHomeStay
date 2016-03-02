//
//  ENotification.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 5/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

enum ENotification : Int, CustomStringConvertible {
  
  case EnquiryReceived = 1 //Orange
  case EnquiryResponse = 2 //Green
  case Message = 3         //Green
  case ReviewReceived = 4  //Orange
  case ReviewToBeDone = 5  //Green
  case TakePhoto = 6       //Orange
  case PhotoReceived = 7      //Green
  
  var description: String {
    switch self {
    case .EnquiryReceived:
      return "Enquiry Received"
    case .EnquiryResponse:
      return "Enquiery Response"
    case .Message:
      return "Message"
    case .ReviewReceived:
      return "Review Received"
    case .ReviewToBeDone:
      return "Review To Be Done"
    case .TakePhoto:
      return "Take A Photo"
    case .PhotoReceived:
      return "Photo Received"
    }
  }
}