//
//  Notification.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 5/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Notification {
  
  let notificationType : ENotification
  let message : String
  let date : NSDate
  let sender : User
  var imageId : String?
  
  init (notificationType: ENotification, message: String, date: NSDate, sender: User) {
    self.notificationType = notificationType
    self.message = message
    self.date = date
    self.sender = sender
  }
  
  func isHostNotification()  -> Bool {
    switch (notificationType) {
    case .EnquiryReceived:
      return true
    case .ReviewReceived:
      return true
    case .TakePhoto:
      return true
    default: return false
    }
  }
}