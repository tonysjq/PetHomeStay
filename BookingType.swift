//
//  BookingType.swift
//  PetHomeStay
//
//  Created by YangBo on 15/8/26.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class BookingType: UIViewController{
    
    @IBOutlet weak var uploadPic: UIImageView!
    @IBOutlet weak var petName: UITextField!
    @IBOutlet weak var dogbutton: UIButton!
    @IBOutlet weak var cat: UIButton!
    @IBOutlet weak var other: UIButton!
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    @IBOutlet weak var breed: UIButton!
    @IBOutlet weak var age1: UIButton!
    @IBOutlet weak var age2: UIButton!
    @IBOutlet weak var energy1: UIButton!
    @IBOutlet weak var energy2: UIButton!
    @IBOutlet weak var energy3: UIButton!
    @IBOutlet weak var size1: UIButton!
    @IBOutlet weak var size2: UIButton!
    @IBOutlet weak var size3: UIButton!
    @IBOutlet weak var size4: UIButton!
    @IBOutlet weak var submit: UIButton!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     age1.hidden = false
     breed.hidden = false
     age2.hidden = true
     submit.layer.backgroundColor = AppConstants.COLOR_GREEN_SUCCESS.CGColor
     submit.layer.cornerRadius = 5
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        //Add the recognizer to your view.
        dogbutton.addGestureRecognizer(tapRecognizer)
        
    
        
    
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        dogbutton.layer.backgroundColor = AppConstants.COLOR_PET_HOME_STAY_ORANGE.CGColor
        cat.layer.backgroundColor = UIColor.clearColor().CGColor
        other.layer.backgroundColor = UIColor.clearColor().CGColor
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
