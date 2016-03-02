//
//  EEnergyLevels.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 20/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

enum EPetEnergyLevel : Int, CustomStringConvertible {
  
  case Low = 1
  case LowMedium = 2
  case Medium = 3
  case HighMedium = 4
  case High = 5
  
  var description: String {
    switch self {
    case .Low:
      return "Low"
    case .LowMedium:
      return "Low Medium"
    case .Medium:
      return "Medium"
    case .HighMedium:
      return "High Medium"
    case .High:
      return "High"
    }
  }
}