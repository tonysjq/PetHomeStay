//
//  ScalesContainer.swift
//  PetHomeStay
//
//  Created by Siti Nur Aini Zahari on 27/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

/**
  * Skills Container displayed in the HostProfileView.
  */
class HostSkillsContainer: UIViewController{
  
  @IBOutlet var PetSizeXLarge: UIImageView!
  @IBOutlet var PetSizeLarge: UIImageView!
  @IBOutlet var PetSizeMedium: UIImageView!
  @IBOutlet var PetSizeSmall: UIImageView!
  
  @IBOutlet var PetSizeXLargeLabel: UILabel!
  @IBOutlet var PetSizeLargeLabel: UILabel!
  @IBOutlet var PetSizeMediumLabel: UILabel!
  @IBOutlet var PetSizeSmallLabel: UILabel!
  
  @IBOutlet var PetEnergyCalm: UIImageView!
  @IBOutlet var PetEnergyMedium: UIImageView!
  @IBOutlet var PetEnergyEnergetic: UIImageView!
  
  @IBOutlet var PetEnergyCalmLabel: UILabel!
  @IBOutlet var PetEnergyMediumLabel: UILabel!
  @IBOutlet var PetEnergyEnergeticLabel: UILabel!
  
  @IBOutlet var emergencyTransportImg: UIImageView!
  @IBOutlet var policeCheckImg: UIImageView!
  @IBOutlet var ConstantSupervision: UIImageView!
  
  func fillSkillsContainer(homestay : Homestay) {
    hideAllPetPreferences()
    
    for energyLevel in homestay.profile.energyLevels {
      switch (energyLevel) {
      case .High:
        PetEnergyEnergetic.hidden = false
        PetEnergyEnergeticLabel.hidden = false
        break
      case .Medium:
        PetEnergyMedium.hidden = false
        PetEnergyMediumLabel.hidden = false
        break
      case .Low:
        PetEnergyCalm.hidden = false
        PetEnergyCalmLabel.hidden = false
        break
      default: break
      }
    }
    
    if (!homestay.profile.emergencyTransport){
      emergencyTransportImg.hidden = false
    }
    
    if (!homestay.profile.policeCheck){
      policeCheckImg.hidden = false
    }
    
    if (!homestay.profile.constantSupervision) {
      ConstantSupervision.hidden = false
    }
  }
  
  private func hideAllPetPreferences() {
    PetSizeXLarge.hidden = true
    PetSizeLarge.hidden = true
    PetSizeMedium.hidden = true
    PetSizeSmall.hidden = true
    
    PetSizeXLargeLabel.hidden = true
    PetSizeLargeLabel.hidden = true
    PetSizeMediumLabel.hidden = true
    PetSizeSmallLabel.hidden = true
    
    PetEnergyEnergetic.hidden = true
    PetEnergyMedium.hidden = true
    PetEnergyCalm.hidden = true
    
    PetEnergyEnergeticLabel.hidden = true
    PetEnergyMediumLabel.hidden = true
    PetEnergyCalmLabel.hidden = true
    
    emergencyTransportImg.hidden = true
    policeCheckImg.hidden = true
    ConstantSupervision.hidden = true
  }
}