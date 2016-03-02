//
//  Location.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Location {
  
  let address : Address
  
  let longitude : Double
  let latitude : Double
  
  init (location : JSON!) {
    print(location)
    address = Address(address: location["address"])
    longitude = location["position"]["longitude"].doubleValue
    latitude = location["position"]["latitude"].doubleValue
  }
}