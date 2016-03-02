//
//  ButtonStyle.swift
//  PetHomeStay
//
//  Created by YangBo on 15/9/2.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class ButtonStyle: UIButton {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame:frame)
        setupButtonStyle()
    }
    
    override func awakeFromNib() {
        setupButtonStyle()
    }
    
    func setupButtonStyle(){
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        self.layer.borderColor = AppConstants.COLOR_PET_HOME_STAY_ORANGE.CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
        self.setTitleColor(AppConstants.COLOR_PET_HOME_STAY_ORANGE, forState: UIControlState.Normal)
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
