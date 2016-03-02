//
//  HostReviewController.swift
//  PetHomeStay
//
//  Created by Admin on 22/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//
import UIKit

class HostReviewController: UIViewController {
    var hostName:String?
    var hostID:String?
    var hostTitle:String?
    var hostDescription:String?
    
    var results : JSON!
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Reading JSON Test from Local Device!
        if let path = NSBundle.mainBundle().pathForResource("hostresults", ofType: "json"){
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil){
                results = JSON(data: jsonData)["homestays"]
            }
        }
        
        var inthostID: Int! = hostID!.toInt()
        
        for (index, object) in results {
            let id = object["id"].stringValue
            let inid: Int! = id.toInt()
            if(inid == inthostID ){
                hostName = object["host"]["first_name"].string
                hostTitle = object["title"].string
                hostDescription = object["description"].string
                lblname.text = hostName
                lbltitle.text = hostTitle
            }
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        let title = "Your Booking is successfull \n "
        
        let alert = UIAlertController(
            title: title,
            message: "Thank you for booking at PetHomeStay",
            preferredStyle: .Alert)
        
        let action = UIAlertAction(
            title: "Close this pop-up",
            style: .Default,
            handler: nil)
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}