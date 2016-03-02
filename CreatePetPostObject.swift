//
//  CreatePetRequest.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 5/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class CreatePetPostObject : Serializable {
  
  
  let pet : Pet!
  let user_token: String! //Logged User Token
  let token : String!
  
  init (pet: Pet, userToken: String) {
    self.pet = pet
    self.user_token = userToken
    self.token = AppAPI.TOKEN
  }
}