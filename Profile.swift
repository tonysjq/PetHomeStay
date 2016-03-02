//
//  Profile.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class Profile {
  let policeCheck : Bool
  let emergencyTransport : Bool
  let constantSupervision : Bool
  
  var favouriteBreeds = [DogBreed]()
  var energyLevels  = [EPetEnergyLevel]()
  
  init (profile : JSON!) {
    policeCheck = profile["police_check"].boolValue
    emergencyTransport = profile["emergency_transport"].boolValue
    constantSupervision = profile["constant_supervision"].boolValue
    
    for (_, favouriteBreeds) in profile["favourite_breeds"]{
      self.favouriteBreeds.append(DogBreed(breedName: favouriteBreeds.string!))
    }
    
    for (_, energyLevels) in profile["accepted_energy_levels"]{
      self.energyLevels.append(EPetEnergyLevel(rawValue: energyLevels.intValue)!)
    }
  }
}