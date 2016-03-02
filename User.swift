//
//  User.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 9/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class User : Serializable {
  
  let first_name : String
  let last_name : String
  let email : String
  let password : String?
  
  var id : Int?
  var facebookId : Double?
  var image : Image?
  var token : String?
  
  init (firstName: String, lastName: String, email: String, password: String?) {
    self.first_name = firstName
    self.last_name = lastName
    self.email = email
    self.password = password
  }
  
  convenience init (id: Int, firstName: String, lastName: String, email: String, token: String) {
    self.init(firstName: firstName, lastName: lastName, email: email, password: nil)
    self.id = id
    self.token = token
  }
}