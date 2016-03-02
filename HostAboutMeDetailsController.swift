//
//  AboutMeDetailsController.swift
//  PetHomeStay
//
//  Created by Siti Nur Aini Zahari on 21/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

/**
  * AboutMeDetails UIViewController.
  */
class HostAboutMeDetailsController: UIViewController {

  var homestayDescription : String?
  
  @IBOutlet weak var lbldesc: UITextView!
  @IBOutlet weak var aboutMe: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    aboutMe.textColor = AppConstants.Colors.Orange
    lbldesc.text = homestayDescription
  }
}
