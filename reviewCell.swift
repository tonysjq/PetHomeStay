//
//  reviewCell.swift
//  DynamicCell
//
//  Created by Siti Nur Aini Zahari on 10/09/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit

class reviewCell : UITableViewCell {
  
  
  @IBOutlet var ReviewImage: UIImageView!
  @IBOutlet var ReviewName: UILabel!
  @IBOutlet var ReviewDate: UILabel!
  @IBOutlet var Review: UILabel!
  @IBOutlet var ReviewRating: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    //ReviewImage.layer.cornerRadius = 40
    //ReviewImage.clipsToBounds = true
    //ReviewImage.layer.borderWidth = 3
    // Initialization code
  }
}