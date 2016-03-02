//
//  PickupContainer.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/9/17.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import Foundation

/**
  * Pick Up Container for the Calendar.
  */
class PickupContainer: UIViewController{
  
  
  @IBOutlet var pickupCalendar: FSCalendar!

  override func viewDidLoad() {
    super.viewDidLoad()
    pickupCalendar.frame=CGRect(x: 0, y: 0, width: 150, height: 300)
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}