//
//  ReviewListCell.swift
//  PetHomeStay
//
//  Created by Admin on 23/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit

class ReviewListCell : UITableViewCell {

  @IBOutlet var ReviewImage: UIImageView!
  @IBOutlet var ReviewName: UILabel!
  @IBOutlet var ReviewDate: UILabel!
  @IBOutlet var Review: UILabel!
  @IBOutlet var ReviewRating: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    ReviewImage.layer.cornerRadius = 40
    ReviewImage.clipsToBounds = true
    ReviewImage.layer.borderColor = AppConstants.Colors.Orange.CGColor
    ReviewImage.layer.borderWidth = 3
    // Initialization code
  }
}