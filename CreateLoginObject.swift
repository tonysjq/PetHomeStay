//
//  CreateLoginObject.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 29/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class CreateLoginObject : Serializable {
  
  let email: String!      //DO NOT CHANGE NAME - MAPPING API
  let password : String?  //DO NOT CHANGE NAME - MAPPING API
  let device : Device?    //DO NOT CHANGE NAME - MAPPING API
  let oauth : Oauth?      //DO NOT CHANGE NAME - MAPPING API
  
  init (email: String!, password: String?, device: Device?, oauth: Oauth?) {
    self.email = email
    self.password = password
    self.device = device
    self.oauth = oauth
  }
}