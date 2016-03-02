//
//  Service.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Service {
  
  let price : Int
  let service : EService
  
  init(service: EService, price: Int) {
    self.service = service;
    self.price = price
  }
}