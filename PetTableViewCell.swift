//
//  TableViewCell.swift
//  fdd
//
//  Created by Shuaiji Qian on 15/9/30.
//  Copyright (c) 2015年 rmit. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {

  @IBOutlet var CellTitle: UILabel!
  @IBOutlet var petname: UILabel!
  @IBOutlet var petImage: UIImageView!
  @IBOutlet var petdate: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      petImage.layer.cornerRadius = 40
      
      petImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
