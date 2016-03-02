//
//  CreateDeviceObject.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 29/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class CreateDeviceObject : Serializable {
  
  let device: Device!
  
  init (name: String!, token: String!) {
    self.device = Device(name: name, token: token)
  }
}