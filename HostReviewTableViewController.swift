//
//  ReviewContainer.swift
//  PetHomeStay
//
//  Created by Siti Nur Aini Zahari on 27/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import UIKit

/**
  * UITableViewCOntroller holding the Reviews from a Host.
  */
class HostReviewTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  var reviewName: String?
  var reviews = [Review]()
  
  @IBOutlet weak var reviewTBV: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.reviewTBV.delegate = self
    self.reviewTBV.dataSource = self
    self.reviewTBV.rowHeight = UITableViewAutomaticDimension
    self.reviewTBV.estimatedRowHeight = 1800.0
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      self.reviewTBV.reloadData()
      self.reviewTBV.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
    })
    
    self.reviewTBV.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  private func reloadData() {
    self.reviewTBV.reloadData()
  }
  
  func fillReviewContainer(reviews : [Review]){
    self.reviews = reviews
    self.reloadData()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviews.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
    let reviewCell = tableView.dequeueReusableCellWithIdentifier("reviewCell", forIndexPath: indexPath) as! ReviewListCell
    
    let ownReview = reviews[indexPath.row]
    
    reviewCell.ReviewName.textColor = AppConstants.Colors.Orange
    reviewCell.ReviewName.text = ownReview.firstName
    let timeDate = ownReview.createDate
    reviewCell.ReviewDate.text = AppUtils.unixDateToClientFormat(timeDate)
    
    let userReview = ownReview.reviews
    
    if (userReview.isEmpty) {
      reviewCell.Review.text = ""
    }
    else {
      reviewCell.Review.text = "\"\(userReview)\""
    }
    
    let reviewPhotoID = UIImage(named: "DefaultProfile")
    reviewCell.ReviewImage.image = reviewPhotoID
   
    if let reviewPhotoID = ownReview.imageID{
      print("Row: \(indexPath.row)")
      print("Image ID: " + reviewPhotoID)
      AppImagesPool.getImage(reviewPhotoID, imageView: reviewCell.ReviewImage, setWatermark: false)
    }
    
    let reviewRating = ownReview.rating
    print("RATING: \(reviewRating)")
    
    if reviewRating == 1 {
      let reviewRatingPhoto = UIImage(named: "1star")
      reviewCell.ReviewRating.image = reviewRatingPhoto
    }
    else if reviewRating == 2 {
      let reviewRatingPhoto = UIImage(named: "2star")
      reviewCell.ReviewRating.image = reviewRatingPhoto
    }
    else if reviewRating == 3 {
      let reviewRatingPhoto = UIImage(named: "3star")
      reviewCell.ReviewRating.image = reviewRatingPhoto
    }
    else if reviewRating == 4 {
      let reviewRatingPhoto = UIImage(named: "4star")
      reviewCell.ReviewRating.image = reviewRatingPhoto
    }
    else if reviewRating == 5 {
      let reviewRatingPhoto = UIImage(named: "5star")
      reviewCell.ReviewRating.image = reviewRatingPhoto
    } else {
      let reviewRatingPhoto = UIImage(named: "")
      reviewCell.ReviewRating.image = reviewRatingPhoto
    }
    
    return reviewCell
  }
  
  
  
}
