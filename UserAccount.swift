//
//  UserAccount.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 29/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class UserAccount : Serializable {
  
  let first_name : String
  let last_name : String
  let email : String
  let password : String?
  
  init (firstName: String, lastName: String, email: String, password: String?) {
    self.first_name = firstName
    self.last_name = lastName
    self.email = email
    self.password = password
  }
}