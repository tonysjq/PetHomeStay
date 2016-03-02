//
//  JsonParser.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class JsonObjectFactory {
  
  /**
   * Method to Parse a User from JSON.
   */
  class func parseUserFromLogin(json: JSON) -> User {
    let id = json["id"].intValue
    let firstName = json["first_name"].stringValue
    let lastName = json["last_name"].stringValue
    let email = json["email"].stringValue
    let token = json["token"].stringValue
    
    let user = User(id: id, firstName: firstName, lastName: lastName, email: email, token: token)
    user.image = parseImage(json["image"])
    
    return user
  }
  
  class func parsePets(json: JSON) -> [Pet] {
    var pets = [Pet]()
    
    for (_, pet) in json {
      pets.append(parsePet(pet))
    }
    
    return pets
  }
  
  class func parsePet(json: JSON) -> Pet {
    let id = json["id"].intValue
    let name = json["name"].stringValue
    let type = EPetType(rawValue: json["type"].intValue)
    let age = json["age"].intValue
    let sex = EPetSex(rawValue: json["sex"].intValue)
    let size = EPetSize(rawValue: json["size"].intValue)
    let energyLevel = EPetEnergyLevel(rawValue: json["energy_level"].intValue)
    
    var petImage : Image?
    
    if (json["image"] != nil) {
      petImage = parseImage(json["image"])
    }
    
    let pet = Pet(id: id, name: name, image: petImage)
    pet.type = type
    pet.age = age
    pet.sex = sex
    pet.size = size
    pet.energy_level = energyLevel
    
    return pet
  }
  
  /**
   * Method to Parse an Image from JSON.
   */
  class func parseImage(json: JSON) -> Image {
    let id = json["id"].stringValue
    let type = json["type"].stringValue
    
    return Image(ID: id, type: type)
  }
  
  /**
   * Method to parse an Error from JSON.
   */
  class func parseError(json: JSON) -> Error {
    let code = json["code"].intValue
    let type = json["type"].stringValue
    let description = json["description"].stringValue
    
    let error = Error(code: code, type: type, description: description)
    
    for (_, message) in json["messages"] {
      error.messages.append(message.stringValue)
    }
    
    return error
  }
}