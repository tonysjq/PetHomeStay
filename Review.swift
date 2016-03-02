//
//  Review.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Review {
  
  var firstName : String
  let imageID : String?
  var rating : Int
  var reviews : String
  var createDate : Double
  
  init (review : JSON) {
    imageID = review["user"]["image"]["id"].string
    firstName = review["user"]["first_name"].stringValue
    createDate = review["created_at"].double!
    reviews = review["review"].stringValue
    rating = review["rating"].intValue
  }
}