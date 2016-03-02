//
//  Homestay.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 4/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

class Homestay {
  
  let id : Int
  let host : Host
  let title : String

  let description : String?
  let profilePhotoID : String?
  let distance : Double
  
  let location : Location
  let profile : Profile
  var reviews = [Review]()
  var images = [Image]()
  var services = [Service]()
  
  init (homestay : JSON!) {
    id = homestay["id"].intValue
    title = homestay["title"].stringValue
    
    host = Host(host: homestay["host"])
    location = Location(location: homestay["location"])

    for (_, prices) in homestay["prices"]{
      let price = prices["price"]
      
      if (price != nil) {
        self.services.append(Service(service: EService(rawValue: prices["service"].stringValue)!, price: price.intValue))
      }
    }
    
    profilePhotoID = homestay["image"]["id"].string
    profile = Profile(profile: homestay["profile"])
    description = homestay["description"].string
    distance = homestay["distance"].doubleValue
    
    for (_, review) in homestay["reviews"] {
      reviews.append(Review(review: review))
    }
    
    for (_, image) in homestay["images"] {
      let imageId = image["id"].stringValue
      let imageType = image["type"].stringValue
      
      images.append(Image(ID: imageId, type: imageType))
    }
  }
  
  //Find the first photo different to the profile.
  func getLandscapeImageID() -> String? {
    var landscapeID : String?
    
    for image in images {
      if image.ID != profilePhotoID {
        landscapeID = image.ID
        break
      }
    }
    
    if landscapeID == nil {
      landscapeID = profilePhotoID
    }
    return landscapeID
  }
}