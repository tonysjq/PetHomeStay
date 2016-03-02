//
//  DashboardCard.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 7/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class DashboardCard {
  
  var pets = [Pet]()
  let type : EDashboardCardType
  let date : String //e.g. Nov 12 - Nov 15
  let messages : Int
  let price : Int
  let host : DashboardHost
  var rating = 0 as CGFloat
  
  init (type: EDashboardCardType, date: String, messages: Int, price: Int, host: DashboardHost) {
    self.type = type
    self.date = date
    self.messages = messages
    self.price = price
    self.host = host
  }
}