//
//  Util.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 18/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

/**
 * Utility class holding general util methods.
 */
class AppUtils {
  
  private init() {
    
  }
  
  //Change UNIX date format to readable format
  class func unixDateToClientFormat(unixDate: Double) -> String {
    let timeDate1 = NSDate(timeIntervalSince1970: unixDate)
    return dateToClientFormat(timeDate1)
  }
  /**
   * Get the String of a Date in format dd/MM/yyyy
   */
  class func dateToClientFormat(date: NSDate) -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    let result = formatter.stringFromDate(date)
    return result
  }
  
  /**
   *  Print Current Date on Console.
   */
  class func printCurrentDate() {
    let dateFormatter:NSDateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    
    print(dateFormatter.stringFromDate(NSDate()))
  }
  
  class func evaluateEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluateWithObject(email)
  }
  
  class func showAlert(message: String, view: UIViewController) {
    let alert = UIAlertController(title: "PetHomeStay", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    view.presentViewController(alert, animated: true, completion: nil)
  }
}