//
//  FacebookAuth.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 15/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Oauth : Serializable {
  
  let provider : String!
  let token : String!
  
  init (provider: String!, token: String!) {
    self.provider = provider
    self.token = token
  }
}