//
//  HomeController.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 12/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit
import CoreLocation

/**
 * Home Controller contains the basic view for Searching with a Postcode.
 */
class HomeController: UIViewController, UISearchBarDelegate, UITabBarControllerDelegate {
  
  @IBOutlet var SearchBar: UISearchBar!
  @IBOutlet var SearchButton: PHSButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.hidden = true
    self.tabBarController?.delegate = self
    
    SearchBar.delegate = self
    
    //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
    //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
    view.addGestureRecognizer(tap)
        
    SearchButton.addTarget(self, action: "buttonSearchAction:", forControlEvents: UIControlEvents.TouchUpInside)
  }
  
  /*
  override func getLocationInfo(placemark: CLPlacemark) {
    super.getLocationInfo(placemark)
    SearchBar.text = placemark.postalCode
    println(placemark.postalCode)
    performSearchAction()
  }
  */
  
  func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
    if (AppData.UserToken != nil) {
      return true
    }
    
    if (viewController.restorationIdentifier == "HomeNavController") {
      return true
    }
      
    self.performSegueWithIdentifier("GoToLogin", sender: self)
    return false
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBar.hidden = true
    self.tabBarController?.tabBar.hidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //Calls this function when the tap is recognized.
  func DismissKeyboard(){
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  /*func keyboardWillShow(sender: NSNotification){
    self.view.frame.origin.y -= 150
  }
  
  func keyboardWillHide(sender: NSNotification){
    self.view.frame.origin.y += 150
  }*/
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    if (searchText.characters.count != 4) {
      SearchButton.backgroundColor = UIColor.lightGrayColor()
    }
    else {
      SearchButton.backgroundColor = AppConstants.Colors.Green_Success
    }
  }
  
  //Action declared for the SearchButton.
  func buttonSearchAction(sender:UIButton!)
  {
    performSearchAction()
  }
  
  func performSearchAction() {
    if (SearchBar.text!.characters.count != 4) {
      print("4 Digits POSTCODE is required")
    }
    else {
      print(SearchBar.text)
      performSegueWithIdentifier("ShowResults", sender: self)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
    if (segue.destinationViewController is ResultsViewController) {
      let hostListViewController = segue.destinationViewController as! ResultsViewController
      hostListViewController.postcode = SearchBar.text
    }
    else if (segue.destinationViewController is SignupViewController) {
      let signupViewController = segue.destinationViewController as! SignupViewController
      signupViewController.comingFromTabBar = true
    }
  }
}
