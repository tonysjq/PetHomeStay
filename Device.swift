//
//  Device.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 29/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Device : Serializable {
  
  let name : String!
  let token : String!
  
  init (name: String!, token: String!) {
    self.name = name
    self.token = token
  }
}