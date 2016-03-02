//
//  EPetSize.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 20/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

enum EPetType : Int, CustomStringConvertible {
  
  case Dog = 1
  case Cat = 2
  case Bird = 3
  case Fish = 4
  case Other = 5
  
  var description: String {
    switch self {
    case .Dog:
      return "Dog"
    case .Cat:
      return "Cat"
    case .Bird:
      return "Bird"
    case .Fish:
      return "Fish"
    case .Other:
      return "Other"
    }
  }
}