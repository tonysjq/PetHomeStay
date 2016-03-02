//
//  CreateFacebookOAuthObject.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 15/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class CreateFacebookOAuthObject : Serializable {
    
  let oauth: Oauth!
  
  init (provider: String!, token: String!) {
    self.oauth = Oauth(provider: provider, token: token)
  }
}