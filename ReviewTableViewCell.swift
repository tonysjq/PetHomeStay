//
//  reviewTableViewCell.swift
//
//
//  Created by Shuaiji Qian on 15/9/30.
//
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
  
  @IBOutlet var ratingview: HCSStarRatingView!
  
  @IBOutlet var reviewlabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
 
    
    // Initialization code
  }
  
  //after change the star print the value
  

  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
