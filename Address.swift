//
//  Address.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation


class Address {
  
  let suburb : String
  
  init (address : JSON) {
    suburb = address["suburb"].stringValue
  }
}