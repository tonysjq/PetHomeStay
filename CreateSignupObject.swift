//
//  CreateSignupObject.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 29/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class CreateSignupObject : Serializable {
  
  let user: UserAccount!  //DO NOT CHANGE NAME - MAPPING API
  let device : Device?    //DO NOT CHANGE NAME - MAPPING API
  let oauth : Oauth!      //DO NOT CHANGE NAME - MAPPING API
  
  init (user: UserAccount!, device: Device?, oauth: Oauth!) {
    self.user = user
    self.device = device
    self.oauth = oauth
  }
}