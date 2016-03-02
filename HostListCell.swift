//
//  HostListCell.swift
//
//  Created by Apple on 17/05/2015.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit

class HostListCell : UITableViewCell {
  
  var pageImages: [Image] = []
  var pageViews: [UIImageView?] = []
  var pageCount = 1
  
  //Host Photos
  //@IBOutlet var landscapeImage: UIImageView!
  @IBOutlet var profilePhoto: PHSAvatarImage!
  @IBOutlet var Scroller: UIScrollView!
  //Host Details
  @IBOutlet var hostName: UILabel!
  @IBOutlet var hostTitle: UILabel!
  @IBOutlet var location: UILabel!
  @IBOutlet var priceTag: UILabel!
  
  //Host Service Icons
  @IBOutlet var serviceIcon1: UIImageView!
  @IBOutlet var serviceIcon2: UIImageView!
  @IBOutlet var serviceIcon3: UIImageView!
  @IBOutlet var serviceIcon4: UIImageView!
  @IBOutlet var serviceIcon5: UIImageView!
  
  //Review Star
  @IBOutlet var ratingImage: UIImageView!
  @IBOutlet var ratingLabel: UILabel!
  
  //Review Photos
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

  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func fillHostListCell(homestay: Homestay) {
    fillHomestayDetails(homestay)
    fillServicesIcons(homestay.services)
    fillAverageRatingStar(homestay.host.averageRating)
    fillReviewsAvatars(homestay.reviews)
    setScrollViewSize(homestay)
    createLineSeparator()
  }
  
  private func setScrollViewSize(homestay: Homestay){
    pageImages = homestay.images
    pageViews = [UIImageView]()
    pageCount = 1
    
    let subViews = self.Scroller.subviews
    for subview in subViews{
      subview.removeFromSuperview()
    }
    
    let scrollPoint = CGPointMake(0.0, 0.0)
    if (self.Scroller != nil) {
      self.Scroller!.setContentOffset(scrollPoint, animated: false)
    }
    
    if (pageImages.count > 0) {
      pageCount = pageImages.count
    }
    
    for _ in 0..<pageCount {
      pageViews.append(nil)
    }
    
    let pagesScrollViewSize = Scroller.frame.size
    Scroller.contentSize = CGSizeMake(420/*pagesScrollViewSize.width*/ * CGFloat(pageCount), pagesScrollViewSize.height)
    
    loadVisiblePages()
  }
  
  func loadVisiblePages() {
    
    // First, determine which page is currently visible
    let pageWidth = Scroller.frame.size.width
    let page = Int(floor((Scroller.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
    
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
      _ = Scroller.bounds
      
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
      Scroller.addSubview(newPageView)
      
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
  
  private func fillHomestayDetails(homestay: Homestay) {
    self.hostName.text  = homestay.host.firstName;
    self.hostTitle.text = homestay.title
    self.location.text  = homestay.location.address.suburb;
    self.priceTag.text  = "$\(homestay.services[0].price)"
  }
  
  private func fillServicesIcons(services : [Service]) {
    //Services
    self.hideAllServicesIcons()
    
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
  
  private func fillReviewsAvatars(reviews: [Review]) {
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
  
  private func createLineSeparator() {
    let additionalSeparator = UIView(frame: CGRectMake(0, self.frame.size.height-3, self.frame.size.width,3));
    additionalSeparator.backgroundColor = UIColor.blackColor()
    self.addSubview(additionalSeparator)
    
    self.selectionStyle = UITableViewCellSelectionStyle.None;
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
  
  func hideAllServicesIcons() {
    self.serviceIcon1.hidden = true
    self.serviceIcon2.hidden = true
    self.serviceIcon3.hidden = true
    self.serviceIcon4.hidden = true
    self.serviceIcon5.hidden = true
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
