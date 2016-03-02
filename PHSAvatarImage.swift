//
//  PHSAvatarImage.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 16/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit

class PHSAvatarImage : UIImageView {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = 37
    self.clipsToBounds = true
    self.layer.borderColor = UIColor.whiteColor().CGColor
    self.layer.borderWidth = 3
  }
}
