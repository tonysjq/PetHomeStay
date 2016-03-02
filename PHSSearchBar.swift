//
//  SearchBar.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 13/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

class PHSSearchBar : UISearchBar {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    //Set the Image to SearchBarIcon.
    let image = UIImage(named: "search.png")
    self.setImage(image, forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
  
    //self.barTintColor = UIColor.clearColor()
    //self.backgroundColor = UIColor.clearColor()
    //self.layer.backgroundColor = UIColor.clearColor().CGColor*/
    //self.tintColor = UIColor.clearColor()
    
    self.layer.cornerRadius = 4.0
    self.clipsToBounds = true
    self.barTintColor = UIColor.whiteColor()
    
    
    //self.backgroundColor = UIColor.whiteColor()
    
    //Change Corner Radius
    let textField = self.valueForKey("searchField") as! UITextField
    //textField.layer.cornerRadius = 14.0
    textField.font = UIFont(name: "Ubuntu", size: 16)
  }
}