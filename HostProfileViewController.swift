//
//  HostProfileViewController.swift
//  PetHomeStay
//
//  Created by Aini Zahari on 27/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation
import UIKit

/**
  * UIViewController to display the ProfileView from a Host.
  */
class HostProfileViewController: UIViewController, UIScrollViewDelegate {
  var homestay : Homestay?
  var hostID:String?
  var hostName:String?
  var hostTitle:String?
  var hostDescription:String?
  var pageImages: [Image] = []
  var pageViews: [UIImageView?] = []
  var pageCount = 1
  
  @IBOutlet var ReviewContainer: UIView!
  @IBOutlet var AboutContainer: UIView!
  @IBOutlet var SkillsContainer: UIView!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var Booking: UIButton!
  @IBOutlet var LandscapeImage: UIImageView!
  @IBOutlet var ProfilePhoto: UIImageView!
  @IBOutlet var hostFirstName: UILabel!
  @IBOutlet var Hosttitle: UILabel!
  @IBOutlet var Hostprice: UILabel!
  @IBOutlet var Hostlocation: UILabel!
  @IBOutlet var Scroller: UIScrollView!
  @IBOutlet var serviceIcon1: UIImageView!
  @IBOutlet var serviceIcon2: UIImageView!
  @IBOutlet var serviceIcon3: UIImageView!
  @IBOutlet var serviceIcon4: UIImageView!
  @IBOutlet var serviceIcon5: UIImageView!
  @IBOutlet var ratingImage: UIImageView!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var reviewPhoto1: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto2: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto3: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto4: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto5: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto6: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto7: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto8: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto9: PHSAvatarImageSmall!
  @IBOutlet var reviewPhoto10: PHSAvatarImageSmall!
  @IBOutlet var hostPetImage: PHSAvatarImageSmall!
  @IBOutlet var hostPetImage2: PHSAvatarImageSmall!

  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.tabBarController?.tabBar.hidden = true
      
      pageImages = homestay!.images
      
      if (pageImages.count > 0) {
        pageCount = pageImages.count
      }
  
      for _ in 0..<pageCount {
        pageViews.append(nil)
      }
      
      let pagesScrollViewSize = scrollView.frame.size
      scrollView.contentSize = CGSizeMake(420 * CGFloat(pageCount), pagesScrollViewSize.height)
      
      loadVisiblePages()
      
      Hostprice.text = "$\(homestay!.services[0].price)"
      Hostlocation.text = homestay!.location.address.suburb
      ReviewContainer.hidden = false
      AboutContainer.hidden = false
      SkillsContainer.hidden = false
    
      ProfilePhoto.layer.cornerRadius = 37
      ProfilePhoto.clipsToBounds = true
      ProfilePhoto.layer.borderColor = UIColor.whiteColor().CGColor
      ProfilePhoto.layer.borderWidth = 3
    
      Scroller.contentSize.height = 1200
      Booking.setTitle("Contact \(homestay!.host.firstName)", forState: .Normal)
    
      print("Host: ")
    
      if let hostImageurl = homestay!.profilePhotoID {
        AppImagesPool.getImage(hostImageurl, imageView: ProfilePhoto, setWatermark: false)
        print(hostImageurl)
      }
    
      hostFirstName.text = homestay!.host.firstName
      Hosttitle.text = homestay!.title
    
      for myController in self.childViewControllers {
        if (myController is HostFirstReviewContainer){
          let control = myController as! HostFirstReviewContainer
          control.getReview(homestay!.reviews)
        }
        else if (myController is HostAboutMeContainer){
          let control = myController as! HostAboutMeContainer
          control.fillAboutMeContainer(homestay!.description!)
        }
        else if (myController is HostSkillsContainer){
          let control = myController as! HostSkillsContainer
          control.fillSkillsContainer(homestay!)
        }
      }
      
      fillServicesIcons(homestay!.services)
      fillAverageRatingStar(homestay!.host.averageRating)
      fillReviewsAvatars(homestay!.reviews)
      fillPetAvatars(homestay!.host.pets)
      
    }
  
  func loadPage(page: Int) {
    
    if page < 0 || page >= pageCount {
      // If it's outside the range of what you have to display, then do nothing
      return
    }
    
    // 1
    if let _ = pageViews[page] {
      // Do nothing. The view is already loaded.
    } else {
      
      // 2
      _ = scrollView.bounds
      
      // 3
      let newPageView = UIImageView()
      newPageView.contentMode = .ScaleAspectFit
      newPageView.frame = CGRect(x: 420 * CGFloat(page) ,y:0 ,width: 420,height: 200)
      newPageView.backgroundColor = UIColor.lightGrayColor()
      
      if (pageImages.count == 0) {
        newPageView.image = AppImages.ProfileLandscape
      }
      else {
        AppImagesPool.getImage(pageImages[page].ID, imageView: newPageView, setWatermark: false)
      }
      scrollView.addSubview(newPageView)
      
      // 4
      pageViews[page] = newPageView
      
    }
  }
  
  func purgePage(page: Int) {
    
    if page < 0 || page >= pageCount {
      // If it's outside the range of what you have to display, then do nothing
      return
    }
    
    // Remove a page from the scroll view and reset the container array
    if let pageView = pageViews[page] {
      pageView.removeFromSuperview()
      pageViews[page] = nil
    }
    
  }
  
  func loadVisiblePages() {
    
    // First, determine which page is currently visible
    let pageWidth = scrollView.frame.size.width
    let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
    
    // Work out which pages you want to load
    let firstPage = page - 1
    let lastPage = pageCount - 1
    
    
    // Purge anything before the first page
    for var index = 0; index < firstPage; ++index {
      purgePage(index)
    }
    
    // Load pages in our range
    for var index = firstPage; index <= lastPage; ++index {
      loadPage(index)
    }
    
    // Purge anything after the last page
    for var index = lastPage+1; index < pageCount; ++index {
      purgePage(index)
    }
  }
  
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    // Load the pages that are now on screen
    loadVisiblePages()
  }

  private func fillServicesIcons(services : [Service]) {
    //Services
    self.serviceIcon1.hidden = true
    self.serviceIcon2.hidden = true
    self.serviceIcon3.hidden = true
    self.serviceIcon4.hidden = true
    
    var countServices = 0
    var tempServiceIcon : UIImageView
    
    for service in services {
      countServices++
      
      tempServiceIcon = self.getServiceImageView(countServices)
      
      switch service.service {
      case .Local:
        tempServiceIcon.image = AppImages.ServiceLocal
        break
      case .Remote:
        tempServiceIcon.image = AppImages.ServiceRemote
        break
      case .Walking:
        tempServiceIcon.image = AppImages.ServiceWalking
        break
      case .Grooming:
        tempServiceIcon.image = AppImages.ServiceGrooming
        break
      case .Delivery:
        tempServiceIcon.image = AppImages.ServiceDelivery
        break
      }
      
      tempServiceIcon.hidden = false
    }
  }

  private func getServiceImageView(position:Int) -> UIImageView {
    var resultImageView : UIImageView
    
    switch(position) {
    case 1: resultImageView = serviceIcon1; break
    case 2: resultImageView = serviceIcon2; break
    case 3: resultImageView = serviceIcon3; break
    case 4: resultImageView = serviceIcon4; break
    case 5: resultImageView = serviceIcon5; break
    default: resultImageView = UIImageView(); break
    }
    
    return resultImageView
  }
  
  private func fillAverageRatingStar(averageRating: Int) {
    //Star
    if (averageRating == 0) {
      self.ratingImage.hidden = true
    }
    else {
      self.ratingLabel.text = String(averageRating)
      self.ratingImage.hidden = false
    }
  }
  
  private func fillReviewsAvatars(reviews : [Review]) {
    self.hideAllReviewPhotos()
    
    //Review Images!
    var count = 1
    var reviewImageView : PHSAvatarImageSmall?
    
    for review in reviews {
      //#TODO - JDDV: Check how to make this better avoiding the Switch Statement
      switch (count) {
      case 1: reviewImageView = self.reviewPhoto1; break
      case 2: reviewImageView = self.reviewPhoto2; break
      case 3: reviewImageView = self.reviewPhoto3; break
      case 4: reviewImageView = self.reviewPhoto4; break
      case 5: reviewImageView = self.reviewPhoto5; break
      case 6: reviewImageView = self.reviewPhoto6; break
      case 7: reviewImageView = self.reviewPhoto7; break
      case 8: reviewImageView = self.reviewPhoto8; break
      case 9: reviewImageView = self.reviewPhoto9; break
      case 10: reviewImageView = self.reviewPhoto10; break
      default: print("Count is more than 10") //#TODO - JDDV Implement the + more reviews.
      }
      
      if let reviewImage = review.imageID {
        AppImagesPool.getImage(reviewImage, imageView: reviewImageView!, setWatermark: false)
      }
      else {
        reviewImageView?.image = AppImages.Profile
      }
      reviewImageView?.hidden = false
      count++
    }
  }
  
  private func fillPetAvatars(pets: [Pet]) {
    self.hostPetImage.hidden = true
    self.hostPetImage.hidden = true
    
    var first = true
    
    for pet in pets {
      if let petImageID = pet.image?.ID {
        if (first) {
          AppImagesPool.getImage(petImageID, imageView: self.hostPetImage, setWatermark: false)
          self.hostPetImage.hidden = false
          first = false
        }
        else {
          AppImagesPool.getImage(petImageID, imageView: self.hostPetImage2, setWatermark: false)
          self.hostPetImage2.hidden = false
          break
        }
      }
    }
  }
  
  func hideAllReviewPhotos() {
    self.reviewPhoto1.hidden = true
    self.reviewPhoto2.hidden = true
    self.reviewPhoto3.hidden = true
    self.reviewPhoto4.hidden = true
    self.reviewPhoto5.hidden = true
    self.reviewPhoto6.hidden = true
    self.reviewPhoto7.hidden = true
    self.reviewPhoto8.hidden = true
    self.reviewPhoto9.hidden = true
    self.reviewPhoto10.hidden = true
  }

  
  @IBAction func buttonBookPressed(sender: AnyObject) {
    if (AppData.UserToken == nil) { //User is not logged in.
      performSegueWithIdentifier(AppConstants.Segues.ShowSignupView, sender: self)
    }
    else {
      var pets : [Pet]?
      var error : Error?
      
      (pets, error) = AppAPI.getPetsFromUser(AppData.UserToken!)
      
      if error != nil {
        AppUtils.showAlert(error!.messages[0], view: self)
      }
      
      if (pets!.isEmpty) {
        performSegueWithIdentifier(AppConstants.Segues.ShowPetDetailsView, sender: self)
      }
      else {
        performSegueWithIdentifier(AppConstants.Segues.ShowEnquiryView,  sender: self)
      }
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.hidden = false
    let title = homestay!.host.firstName
    self.title = "\(title)'s Profile"
    
    if (AppData.EnquiryProcess == 2) {
      navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("SendRequestViewController") , animated: true)
    }
    else if (AppData.EnquiryProcess == 1) {
      navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("PetDetailsViewController") , animated: true)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}