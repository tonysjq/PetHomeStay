//
//  FirstReviewController.swift
//  PetHomeStay
//
//  Created by Siti Nur Aini Zahari on 18/09/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation

import UIKit

/**
  * Container used in the HostProfile view, holding the First Review Only.
  */
class HostFirstReviewContainer: UIViewController{
  var allReviews = [Review]()
  
  @IBOutlet weak var reviewerName: UILabel!
  @IBOutlet weak var review: UILabel!
  @IBOutlet weak var reviewerDate: UILabel!
  @IBOutlet weak var reviewerReview: UILabel!
  @IBOutlet weak var reviewerAvatar: UIImageView!
  @IBOutlet weak var reviewerRating: UIImageView!
  @IBOutlet weak var readMore: UIButton!
  @IBOutlet weak var noreview: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    noreview.hidden = true
    let lineView = UIView(frame: CGRectMake(0,256,420,1.0))
    lineView.layer.borderWidth = 1.0
    lineView.layer.borderColor = UIColor.darkGrayColor().CGColor
    self.view.addSubview(lineView)
  }
  
  func getReview(reviews : [Review]) {
    allReviews = reviews
    self.review.textColor = AppConstants.Colors.Orange
    
    if allReviews.isEmpty{
      noreview.hidden = false
      reviewerName.hidden = true
      reviewerDate.hidden = true
      reviewerReview.hidden = true
      reviewerAvatar.hidden = true
      reviewerRating.hidden = true
      readMore.hidden = true
    } else {
    
      let review = allReviews[0]
    
      reviewerName.textColor = AppConstants.Colors.Orange
      readMore.setTitleColor(AppConstants.Colors.Orange, forState: .Normal)
      reviewerName.text = review.firstName
      reviewerDate.text =  AppUtils.unixDateToClientFormat(review.createDate)
      reviewerReview.text = review.reviews
    
      let reviewPhoto = UIImage(named: "DefaultProfile")
      reviewerAvatar.image = reviewPhoto
    
      if let reviewPhotoID = review.imageID{
        AppImagesPool.getImage(reviewPhotoID, imageView: reviewerAvatar, setWatermark: false)
      }

      reviewerAvatar.image = reviewPhoto
    
      let reviewRating = review.rating
      print("RATING: \(reviewRating)")
    
      if reviewRating == 1 {
        let reviewRatingPhoto = UIImage(named: "1star")
        reviewerRating.image = reviewRatingPhoto
      }
      else if reviewRating == 2 {
        let reviewRatingPhoto = UIImage(named: "2star")
        reviewerRating.image = reviewRatingPhoto
      }
      else if reviewRating == 3 {
        let reviewRatingPhoto = UIImage(named: "3star")
        reviewerRating.image = reviewRatingPhoto
      }
      else if reviewRating == 4 {
        let reviewRatingPhoto = UIImage(named: "4star")
        reviewerRating.image = reviewRatingPhoto
      }
      else if reviewRating == 5 {
        let reviewRatingPhoto = UIImage(named: "5star")
        reviewerRating.image = reviewRatingPhoto
      } else {
        let reviewRatingPhoto = UIImage(named: "")
        reviewerRating.image = reviewRatingPhoto
      }
    }
  }
  
  @IBAction func buttonMorePressed(sender: AnyObject) {
    performSegueWithIdentifier("reviewTableView", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
    let reviewContainer = segue.destinationViewController as! HostReviewTableViewController
    reviewContainer.reviews = allReviews
  }
}
