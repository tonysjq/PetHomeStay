//
//  EDashboardCardType.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 7/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

enum EDashboardCardType {
  case Booking
  case Review
  var description : String {
    switch self {
      // Use Internationalization, as appropriate.
    case .Booking: return "Booking"
    case .Review: return "Review"
   
    }
  }
}