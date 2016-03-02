//
//  SettingCellWithoutSwtich2.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/7.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class SettingCellWithoutSwtich2: UITableViewCell {


  
  @IBOutlet weak var switchNotification: UISwitch!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    
  }
  
  @IBAction func changeNotification(sender: AnyObject) {
    if switchNotification.on{
      print("Notification switch on")
    }else{
      print("Notification switch off")
    }
  }

}
