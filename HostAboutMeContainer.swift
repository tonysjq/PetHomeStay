//
//  AboutMeContainer.swift
//  PetHomeStay
//
//  Created by Siti Nur Aini Zahari on 27/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

/**
  * Container used in the Host View containing the AboutMe information.
  */
class HostAboutMeContainer: UIViewController {

  @IBOutlet weak var lbldesc: UITextView!
  @IBOutlet weak var aboutMe: UILabel!
  @IBOutlet weak var readMore: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let lineView = UIView(frame: CGRectMake(0,209,420,1.0))
    lineView.layer.borderWidth = 1.0
    lineView.layer.borderColor = UIColor.darkGrayColor().CGColor
    self.view.addSubview(lineView)
  }
  
  func fillAboutMeContainer(description : String) {
    aboutMe.textColor = AppConstants.Colors.Orange
    readMore.setTitleColor(AppConstants.Colors.Orange, forState: .Normal)
    lbldesc.text = description
  }
  
  @IBAction func buttonMorePressed(sender: AnyObject) {
    performSegueWithIdentifier("aboutMeDetails", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
    let AboutMeDetailController = segue.destinationViewController as! HostAboutMeDetailsController
    AboutMeDetailController.homestayDescription = lbldesc.text
  }
}