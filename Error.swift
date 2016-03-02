//
//  Error.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 20/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Error {
  
  let code: Int
  let type: String
  let description: String
  var messages = [String]()
  
  init (code: Int, type: String, description: String) {
    self.code = code
    self.type = type
    self.description = description
  }
}