//
//  PetHostListCell.swift
//  PetHomeStay
//
//  Created by YangBo on 15/8/19.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class PetHostListCell: UITableViewCell {

    @IBOutlet weak var Moment: UIImageView!
    @IBOutlet weak var Photos: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Review: UILabel!
    @IBOutlet weak var Discription: UILabel!
    @IBOutlet weak var Address: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Photos.layer.cornerRadius = Photos.frame.size.width/2
        Photos.clipsToBounds = true
        Photos.layer.borderColor = UIColor.whiteColor().CGColor
        Photos.layer.borderWidth = 3
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
