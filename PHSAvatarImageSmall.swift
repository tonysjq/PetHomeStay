//
//  PHSReviewImageViewSmall.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 4/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//
import UIKit

class PHSAvatarImageSmall : UIImageView {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = 12
    self.clipsToBounds = true
  }
}
