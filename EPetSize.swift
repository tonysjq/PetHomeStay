//
//  EPetSize.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 20/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

enum EPetSize : Int, CustomStringConvertible {
  
  case Small = 1
  case Medium = 2
  case Large = 3
  case Giant = 4
  
  var description: String {
    switch self {
    case .Small:
      return "Small (0-15kg)"
    case .Medium:
      return "Medium (16-30kg)"
    case .Large:
      return "Large (31-45kg)"
    case .Giant:
      return "Giant (46kg+)"
    }
  }
}