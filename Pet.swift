//
//  Pet.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Pet : Serializable {
  
  var id : Int?
  let name : String
  var type : EPetType?
  var image: Image?
  var age : Int?
  var sex : EPetSex?
  var size : EPetSize?
  var energy_level : EPetEnergyLevel?
  var breed : String?
  var numberOfReviews : Int? //Used in the DashboardCards
  var averageRating : Int? //Used in the DashboardCards
  
  init (id: Int, name: String, image: Image?) {
    self.id = id
    self.name = name
    self.image = image
  }
  
  init(name: String) {
    self.name = name
  }
}