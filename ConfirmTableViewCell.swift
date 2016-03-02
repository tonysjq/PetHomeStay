//
//  confirmTableViewCell.swift
//  fdd
//
//  Created by Shuaiji Qian on 15/9/30.
//  Copyright (c) 2015年 rmit. All rights reserved.
//

import UIKit

class ConfirmTableViewCell: UITableViewCell {

  @IBOutlet var messagelabel: UILabel!
 
  @IBOutlet var pricelabelinbandh: UILabel!
  @IBOutlet var pricelabel: UILabel!
  @IBOutlet weak var messagenumber: UILabel!
  @IBOutlet weak var messagenumberinbandh: UILabel!
  @IBOutlet weak var messagebuttoninbandh: UIButton!
  @IBOutlet weak var pricebutton: UIButton!
  @IBOutlet var messagebutton: UIButton!
  @IBOutlet var editbutton: UIButton!
  @IBOutlet var deletebutton: UIButton!
  @IBOutlet var confirmbutton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
     self.pricelabel.hidden=false
     self.messagebutton.hidden=false
     self.messagenumber.hidden=false
     self.confirmbutton.hidden=false
     self.editbutton.hidden=false
     self.deletebutton.hidden=false
     self.pricebutton.hidden=true
     self.messagebuttoninbandh.hidden=true
     self.messagenumberinbandh.hidden=true
     self.pricelabelinbandh.hidden=true
        // Initialization code
    }

 
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
