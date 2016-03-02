//
//  SettingsViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/10/7.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SettingsViewController: UITableViewController {
  
  
  @IBOutlet var menuButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 4
    
  }
  
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
    forRowAtIndexPath indexPath: NSIndexPath) {
      
      
      cell.backgroundColor = AppConstants.Colors.Gray_light
      
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if (indexPath.row == 3) {
      FBSDKLoginManager().logOut()
      
      NSUserDefaults.standardUserDefaults().removeObjectForKey(AppUserDefaultsConstants.UserId)
      NSUserDefaults.standardUserDefaults().removeObjectForKey(AppUserDefaultsConstants.UserToken)
      
      AppData.UserToken = nil
      
      self.tabBarController?.selectedIndex = 0
    }
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let row = indexPath.row as Int!
    
    var cell:UITableViewCell!
    if row==0
    {
      cell = tableView.dequeueReusableCellWithIdentifier("SettingsTableviewCell", forIndexPath: indexPath) as! SettingsTableviewCell
    }
    else if row==1
    {
      cell = tableView.dequeueReusableCellWithIdentifier("SettingCellWithoutSwtich2", forIndexPath: indexPath) as! SettingCellWithoutSwtich2
    }
    else if row==2
    {
      cell = tableView.dequeueReusableCellWithIdentifier("SettingCellWithoutSwtich", forIndexPath: indexPath) as! SettingCellWithoutSwtich
    }
    else if row==3 {
      cell = tableView.dequeueReusableCellWithIdentifier("SettingCellWithoutSwtich3", forIndexPath: indexPath) as! SettingCellWithoutSwtich3
    }
    return cell
  }
  
  
}

