//
//  MyPetListCell.swift
//  PetHomeStay
//
//  Created by YangBo on 15/9/30.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class MyPetListCell: UITableViewCell {
  
  
  @IBOutlet weak var myPetImage: UIImageView!
  @IBOutlet weak var petNameLabel: UILabel!
  @IBOutlet weak var petBreedLabel: UILabel!
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    myPetImage.layer.cornerRadius = 23
    myPetImage.clipsToBounds = true
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
