//
//  OwnerTableViewCell.swift
//  fdd
//
//  Created by Shuaiji Qian on 15/9/30.
//  Copyright (c) 2015年 rmit. All rights reserved.
//

import UIKit

class OwnerTableViewCell: UITableViewCell {

  
 
  @IBOutlet var ownerphoenumlabel: UILabel!
  @IBOutlet var ownerphonenum: UIButton!
 
  @IBOutlet var ownerImage: UIImageView!
  @IBOutlet var owner: UILabel!
    override func awakeFromNib() {
      
       ownerImage.layer.cornerRadius = 40
      
      ownerImage.layer.masksToBounds = true
        super.awakeFromNib()
        // Initialization code
    }
  
  
  


  
      override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
