//
//  EPetSexes.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 20/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

enum EPetSex : Int, CustomStringConvertible {
  
  case MaleDesexed = 1
  case FemaleDesexed = 2
  case MaleEntire = 3
  case FemaleEntire = 4
  
  var description: String {
    switch self {
    case .MaleDesexed:
      return "Male Desexed"
    case .FemaleDesexed:
      return "Female Desexed"
    case .MaleEntire:
      return "Male"
    case .FemaleEntire:
      return "Female"
    }
  }
}