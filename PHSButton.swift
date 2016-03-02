//
//  SearchBar.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 24/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

class PHSButton : UIButton {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = 4.0
    self.clipsToBounds = true
  }
}