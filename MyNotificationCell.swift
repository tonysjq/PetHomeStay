//
//  MyNotificationCell.swift
//  PetHomeStay
//
//  Created by YangBo on 15/9/30.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class MyNotificationCell: UITableViewCell {
  
  @IBOutlet weak var notificationPhoto: UIImageView!
  @IBOutlet var starRating: HCSStarRatingView!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
  }
 
  func disPlayPhotosCell(notification: Notification){
    notificationPhoto.layer.cornerRadius = 25
    notificationPhoto.clipsToBounds = true
    notificationPhoto.layer.borderWidth = 3
    
    if (notification.isHostNotification()) {
      notificationPhoto.layer.borderColor = AppConstants.Colors.Orange.CGColor
    }
    else {
      notificationPhoto.layer.borderColor = AppConstants.Colors.Green_light.CGColor
    }
  }
  
  func fillNotificationCell(notification: Notification) {
    headerLabel.text = notification.message
    dateLabel.text = AppUtils.dateToClientFormat(notification.date)
    
    if (notification.notificationType != ENotification.ReviewToBeDone) {
      starRating.hidden = true
    }
    else {
      starRating.hidden = false
    }
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
