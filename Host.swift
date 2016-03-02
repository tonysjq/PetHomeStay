//
//  Host.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Host {
  let firstName : String
  let averageRating : Int
  
  var pets = [Pet]()
  
  init (host : JSON!) {
    firstName = host["first_name"].stringValue
    averageRating = host["average_rating"].intValue
    
    var image : Image?
    
    for (_, pet) in host["pets"] {
      
      let petImage = pet["image"]
      
      if (petImage != nil) {
        let imageId = petImage["id"].stringValue
        let imageType = petImage["type"].stringValue
        
        image = Image(ID: imageId, type: imageType)
      }
      else {
        image = nil
      }
      
      pets.append(Pet(id: pet["id"].intValue, name: pet["name"].stringValue, image: image))
    }
  }
}