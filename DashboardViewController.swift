                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    //
//  ThingstodonewViewController.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/10/5.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController,YSSegmentedControlDelegate{
  
  @IBOutlet var threesegmentview: UIView!
  @IBOutlet var thingstodocontainer: UIView!
  @IBOutlet var bookedcontainer: UIView!
  @IBOutlet var historycontainer: UIView!
  
  @IBOutlet var menuButton: UIBarButtonItem!
  
  var thingsToDoController : DashboardCardsTableViewController?
  var bookedController : DashboardCardsTableViewController?
  var historyController : DashboardCardsTableViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    //Segmented Control
    let segmented = YSSegmentedControl(
      frame: CGRect(x: 0, y: 7, width: view.frame.size.width, height: 30),
      titles: [EDashboardView.ThingsToDo.rawValue,
               EDashboardView.Booked.rawValue,
               EDashboardView.History.rawValue],
      action: {
        control, index in
        self.segmentedControlDidPressedItemAtIndex(index)
    })
    
    segmented.appearance.selectorHeight = 3.0
    segmented.appearance.selectorColor = AppConstants.Colors.Orange
    segmented.appearance.bottomLineColor = UIColor.clearColor()
    segmented.selectItemAtIndex(0)
    
    threesegmentview.addSubview(segmented)
    
    //Set Visibility of Containers
    self.bookedcontainer.hidden=true
    self.historycontainer.hidden=true
    self.thingstodocontainer.hidden=false
    
    var count = 0;
    
    for childController in self.childViewControllers {
      if (childController is DashboardCardsTableViewController) {
        //#TODO: - JDDV Double Check this, there should be a better way to identify the containers.
        if (count == 0) {
          thingsToDoController = (childController as! DashboardCardsTableViewController)
          thingsToDoController!.dashboardIdentifier = EDashboardView.ThingsToDo
          thingsToDoController!.dashboard = self
          thingsToDoController!.dashboardCards = DashboardDummyData.thingsToDoCards
          thingsToDoController!.reloadTable()
          
          count++
        }
        else if (count == 1) {
          bookedController = (childController as! DashboardCardsTableViewController)
          bookedController!.dashboardIdentifier = EDashboardView.Booked
          bookedController!.dashboard = self
          bookedController!.dashboardCards = DashboardDummyData.bookedCards
          bookedController!.reloadTable()
          
          count++
        }
        else if (count == 2) {
          historyController = (childController as! DashboardCardsTableViewController)
          historyController!.dashboardIdentifier = EDashboardView.History
          historyController!.dashboard = self
          
          historyController!.dashboardCards = DashboardDummyData.historyCards
          historyController!.reloadTable()
          count++
        }
      }
    }
    
    segmented.delegate = self
  }
  
  func cardConfirmedFromThingsToDo(card: DashboardCard) {
    bookedController!.dashboardCards.append(card)
    DashboardDummyData.bookedCards.append(card) //Keep Model Updated through the app.
    bookedController!.reloadInputViews()
    bookedController!.reloadTable()
  }
  
  func cardDeleteFromThingsToDo(card: DashboardCard) {
    historyController!.dashboardCards.append(card)
    DashboardDummyData.historyCards.append(card) //Keep Model Updated through the app.
    
    historyController!.reloadTable()
  }
  
  func segmentedControlDidPressedItemAtIndex (index: Int) {
    self.bookedcontainer.hidden=true
    self.historycontainer.hidden=true
    self.thingstodocontainer.hidden=true
    
    if index==0 { self.thingstodocontainer.hidden=false }
    if index==1 { self.bookedcontainer.hidden=false }
    if index==2 { self.historycontainer.hidden=false }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}


