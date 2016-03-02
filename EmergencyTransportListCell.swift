//
//  ProfileListCell.swift
//  PetHomeStay
//
//  Created by Admin on 23/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit

class ProfileListCell : UITableViewCell {
    
    //Host Photos
    @IBOutlet var IconImage: UIImageView!
    @IBOutlet var Emergency: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

