//
//  BookingDetailsViewController.swift
//  PetHomeStay
//
//  Created by YangBo on 15/9/9.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit
@IBDesignable

class PetDetailsViewController: UIViewController,
                                UIAlertViewDelegate,
                                UIPopoverControllerDelegate,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate,
                                BreedsViewControllerDelegate,
                                CLUploaderDelegate {
  
  var NameOfBreed: String!
  var Cloudinary:CLCloudinary!
  
  //#MARK: - IBOutlets
  @IBOutlet var photoUpdate: UIImageView!
  @IBOutlet var breedlabel: UILabel!
  @IBOutlet var addPet: UIButton!
  
  @IBOutlet var catImage: UIImageView!
  @IBOutlet var dogImage: UIImageView!
  @IBOutlet var otherImage: UIImageView!

  @IBOutlet var calmImage: UIImageView!
  @IBOutlet var mediumImage: UIImageView!
  @IBOutlet var energeticImage: UIImageView!
  
  @IBOutlet var femaleImage: UIImageView!
  @IBOutlet var maleImage: UIImageView!
  
  @IBOutlet var petNameTextField: UITextField!
  @IBOutlet var petAgeTextField: UITextField!
  
  @IBOutlet var weightImage1: UIImageView!
  @IBOutlet var weightImage2: UIImageView!
  @IBOutlet var weightImage3: UIImageView!
  @IBOutlet var weightImage4: UIImageView!
  
  @IBOutlet weak var catLabel: UILabel!
  @IBOutlet weak var dogLabel: UILabel!
  @IBOutlet weak var otherLabel: UILabel!
  
  @IBOutlet weak var calmLabel: UILabel!
  @IBOutlet weak var mediumLabel: UILabel!
  @IBOutlet weak var energeticLabel: UILabel!
  
  @IBOutlet weak var femaleLabel: UILabel!
  @IBOutlet weak var maleLabel: UILabel!
  
  @IBOutlet weak var weigtLabel1: UILabel!
  @IBOutlet weak var weigtLabel2: UILabel!
  @IBOutlet weak var weigtLabel3: UILabel!
  @IBOutlet weak var weigtLabel4: UILabel!
  
  @IBOutlet var otherPetTypeName: UITextField!
  
  @IBOutlet var dogFaceImage: UIImageView!
  
  //Pet Details!
  var petType = EPetType.Dog
  var petSex = EPetSex.FemaleEntire
  var petSize = EPetSize.Small
  var petEnergyLevel = EPetEnergyLevel.Medium
  
  override func viewDidLoad() {
    super.viewDidLoad()

    AppData.EnquiryProcess = 0
    
    picker?.delegate = self
        breedlabel.text = "Select the breed"
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("breedsTapped:"))
    tapRecognizer.numberOfTapsRequired = 1
    //Add breedlabel recognizer to your view.
    breedlabel.addGestureRecognizer(tapRecognizer)
    photoUpdate.layer.cornerRadius = 30
    photoUpdate.clipsToBounds = true
    
    catImage.image = AppImages.PetDetails.PetTypeCat
    dogImage.image = AppImages.PetDetails.PetTypeDogOrange
    otherImage.image = AppImages.PetDetails.PetTypeOther
    calmImage.image = AppImages.PetDetails.PetEnergyLevelLazy
    mediumImage.image = AppImages.PetDetails.PetEnergyLevelMediumOrange
    energeticImage.image = AppImages.PetDetails.PetEnergyLevelHigh
    femaleImage.image = AppImages.PetDetails.PetSexFemaleOrange
    maleImage.image = AppImages.PetDetails.PetSexMale
    weightImage1.image = AppImages.PetDetails.PetSizeSmallOrange
    weightImage2.image = AppImages.PetDetails.PetSizeMedium
    weightImage3.image = AppImages.PetDetails.PetSizeLarge
    weightImage4.image = AppImages.PetDetails.PetSizeXLarge
    dogLabel.textColor = AppConstants.Colors.Orange
    mediumLabel.textColor = AppConstants.Colors.Orange
    femaleLabel.textColor = AppConstants.Colors.Orange
    weigtLabel1.textColor = AppConstants.Colors.Orange
    
    let tapRecognizer1 = UITapGestureRecognizer(target: self, action: Selector("petTypeTapped:"))
    let tapRecognizer2 = UITapGestureRecognizer(target: self, action: Selector("petTypeTapped:"))
    let tapRecognizer3 = UITapGestureRecognizer(target: self, action: Selector("petTypeTapped:"))
    let tapRecognizer4 = UITapGestureRecognizer(target: self, action: Selector("petEnergyTapped:"))
    let tapRecognizer5 = UITapGestureRecognizer(target: self, action: Selector("petEnergyTapped:"))
    let tapRecognizer6 = UITapGestureRecognizer(target: self, action: Selector("petEnergyTapped:"))
    let tapRecognizer7 = UITapGestureRecognizer(target: self, action: Selector("petSexTapped:"))
    let tapRecognizer8 = UITapGestureRecognizer(target: self, action: Selector("petSexTapped:"))
    let tapRecognizer9 = UITapGestureRecognizer(target: self, action: Selector("petSizeTapped:"))
    let tapRecognizer10 = UITapGestureRecognizer(target: self, action: Selector("petSizeTapped:"))
    let tapRecognizer11 = UITapGestureRecognizer(target: self, action: Selector("petSizeTapped:"))
    let tapRecognizer12 = UITapGestureRecognizer(target: self, action: Selector("petSizeTapped:"))
    
    catImage.addGestureRecognizer(tapRecognizer1)
    dogImage.addGestureRecognizer(tapRecognizer2)
    otherImage.addGestureRecognizer(tapRecognizer3)
    calmImage.addGestureRecognizer(tapRecognizer4)
    mediumImage.addGestureRecognizer(tapRecognizer5)
    energeticImage.addGestureRecognizer(tapRecognizer6)
    femaleImage.addGestureRecognizer(tapRecognizer7)
    maleImage.addGestureRecognizer(tapRecognizer8)
    weightImage1.addGestureRecognizer(tapRecognizer9)
    weightImage2.addGestureRecognizer(tapRecognizer10)
    weightImage3.addGestureRecognizer(tapRecognizer11)
    weightImage4.addGestureRecognizer(tapRecognizer12)
    
    otherPetTypeName.attributedPlaceholder = NSAttributedString(string:"Tell us about your type of pet", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    // Do any additional setup after loading the view.
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  //#MARK: - Tap of Images
  func petTypeTapped(gestureRecognizer: UITapGestureRecognizer) {
    let sourceView = gestureRecognizer.view
    
    dogImage.image = AppImages.PetDetails.PetTypeDog
    catImage.image = AppImages.PetDetails.PetTypeCat
    otherImage.image = AppImages.PetDetails.PetTypeOther
    dogLabel.textColor = UIColor.whiteColor()
    catLabel.textColor = UIColor.whiteColor()
    otherLabel.textColor = UIColor.whiteColor()
    
    dogFaceImage.hidden = true
    breedlabel.hidden = true
    otherPetTypeName.hidden = true
    
    if (sourceView == dogImage) {
      dogImage.image = AppImages.PetDetails.PetTypeDogOrange
      dogLabel.textColor = AppConstants.Colors.Orange
      petType = EPetType.Dog
      dogFaceImage.hidden = false
      breedlabel.hidden = false
    }
    else if (sourceView == catImage) {
      catImage.image = AppImages.PetDetails.PetTypeCatOrange
      catLabel.textColor = AppConstants.Colors.Orange
      petType = EPetType.Cat
    }
    else if (sourceView == otherImage) {
      otherImage.image = AppImages.PetDetails.PetTypeOtherOrange
      otherLabel.textColor = AppConstants.Colors.Orange
      petType = EPetType.Other
      otherPetTypeName.hidden = false
    }
  }

  func petEnergyTapped(gestureRecognizer: UITapGestureRecognizer) {
    let sourceView = gestureRecognizer.view
    
    calmImage.image = AppImages.PetDetails.PetEnergyLevelLazy
    mediumImage.image = AppImages.PetDetails.PetEnergyLevelMedium
    energeticImage.image = AppImages.PetDetails.PetEnergyLevelHigh
    calmLabel.textColor = UIColor.whiteColor()
    mediumLabel.textColor = UIColor.whiteColor()
    energeticLabel.textColor = UIColor.whiteColor()
    
    if (sourceView == calmImage) {
      calmImage.image = AppImages.PetDetails.PetEnergyLevelLazyOrange
      calmLabel.textColor = AppConstants.Colors.Orange
      petEnergyLevel = EPetEnergyLevel.Low
    }
    else if (sourceView == mediumImage) {
      mediumImage.image = AppImages.PetDetails.PetEnergyLevelMediumOrange
      mediumLabel.textColor = AppConstants.Colors.Orange
      petEnergyLevel = EPetEnergyLevel.Medium
    }
    else if (sourceView == energeticImage) {
      energeticImage.image = AppImages.PetDetails.PetEnergyLevelHighOrange
      energeticLabel.textColor = AppConstants.Colors.Orange
      petEnergyLevel = EPetEnergyLevel.High
    }
  }
  
  
  func petSexTapped(gestureRecognizer: UITapGestureRecognizer) {
    let sourceView = gestureRecognizer.view
    
    femaleImage.image = AppImages.PetDetails.PetSexFemale
    maleImage.image = AppImages.PetDetails.PetSexMale
    femaleLabel.textColor = UIColor.whiteColor()
    maleLabel.textColor = UIColor.whiteColor()
    
    
    if (sourceView == femaleImage) {
      femaleImage.image = AppImages.PetDetails.PetSexFemaleOrange
      femaleLabel.textColor = AppConstants.Colors.Orange
      petSex = EPetSex.FemaleEntire
    }
    else if (sourceView == maleImage) {
      maleImage.image = AppImages.PetDetails.PetSexMaleOrange
      maleLabel.textColor = AppConstants.Colors.Orange
      petSex = EPetSex.MaleEntire
    }

  }
  
  func petSizeTapped(gestureRecognizer: UITapGestureRecognizer) {
    let sourceView = gestureRecognizer.view
    
    weightImage1.image = AppImages.PetDetails.PetSizeSmall
    weightImage2.image = AppImages.PetDetails.PetSizeMedium
    weightImage3.image = AppImages.PetDetails.PetSizeLarge
    weightImage4.image = AppImages.PetDetails.PetSizeXLarge
    weigtLabel1.textColor = UIColor.whiteColor()
    weigtLabel2.textColor = UIColor.whiteColor()
    weigtLabel3.textColor = UIColor.whiteColor()
    weigtLabel4.textColor = UIColor.whiteColor()
    
    if (sourceView == weightImage1) {
      weightImage1.image = AppImages.PetDetails.PetSizeSmallOrange
      weigtLabel1.textColor = AppConstants.Colors.Orange
      petSize = EPetSize.Small
    }
    else if (sourceView == weightImage2) {
      weightImage2.image = AppImages.PetDetails.PetSizeMediumOrange
      weigtLabel2.textColor = AppConstants.Colors.Orange
      petSize = EPetSize.Medium
    }
    else if (sourceView == weightImage3) {
      weightImage3.image = AppImages.PetDetails.PetSizeLargeOrange
      weigtLabel3.textColor = AppConstants.Colors.Orange
      petSize = EPetSize.Large
    }
    else if (sourceView == weightImage4) {
      weightImage4.image = AppImages.PetDetails.PetSizeXLargeOrange
      weigtLabel4.textColor = AppConstants.Colors.Orange
      petSize = EPetSize.Giant
    }
  }
  
 
 //#MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.destinationViewController is BreedsViewController) {
      let breedsViewController = segue.destinationViewController as! BreedsViewController
      breedsViewController.delegate = self
    }
  }
  
  func breedsTapped(gestureRecognizer: UITapGestureRecognizer) {
    self.performSegueWithIdentifier("showDogBreedsView", sender: self)
  }
  
  func breedsViewControllerResponse(parameter: String) {
    breedlabel.text = parameter
  }
  
  //#MARK: - Photos, Camera and Gallery
  @IBAction func uploadPic(sender: AnyObject) {
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    let cameraAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default) {
      UIAlertAction in self.openCamera()
    }
    
    let gallaryAction = UIAlertAction(title: "Choose Existing", style: UIAlertActionStyle.Default) {
      UIAlertAction in self.openGallery()
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
      UIAlertAction in
    }
    
    // Add the actions
    alert.addAction(cameraAction)
    alert.addAction(gallaryAction)
    alert.addAction(cancelAction)
    
    // Present the actionsheet
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  var picker:UIImagePickerController?=UIImagePickerController()
  var popover:UIPopoverController?=nil
  
  
  func openCamera() {
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
      // Check if the device supports the use of a camera
      picker!.sourceType = UIImagePickerControllerSourceType.Camera
      self .presentViewController(picker!, animated: true, completion: nil)
    }
    else {
      let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
        alert.dismissViewControllerAnimated(true, completion: nil)
      }))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  func openGallery()
  {
    picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone
    {
      self.presentViewController(picker!, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      self.photoUpdate.contentMode = .ScaleToFill
      self.photoUpdate.image = pickedImage
      
      Cloudinary = CLCloudinary(url: AppConstants.CloudinaryURL)
      
      let uploader:CLUploader = CLUploader(Cloudinary, delegate: self)
      uploader.upload(UIImageJPEGRepresentation(pickedImage, 0.8), options: ["format":"jpg"], withCompletion: { (_: [NSObject : AnyObject]!, errorResult:String!, code:Int, context:AnyObject!) -> Void in
      
      }, andProgress: { (p1:Int, p2:Int, p3:Int, p4:AnyObject!) -> Void in
      
      })
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController)
  {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  //#MARK: - Create Pet Action
  @IBAction func createPetAction(sender: UIButton) {
    let pet = Pet(name: petNameTextField.text!)
    pet.type = petType
    pet.age = Int(petAgeTextField.text!)
    pet.sex = petSex
    pet.size = petSize
    pet.energy_level = petEnergyLevel
    
    pet.breed = breedlabel.text
    
    let createPetRequest = CreatePetPostObject(pet: pet, userToken: AppData.UserToken!)
    
    print(createPetRequest.toJson(false))
    
    let result = AppAPI.getCreatePetRequest(createPetRequest.toJson(false))
    
    if (result.0 != nil) {
      goToSendRequestView()
    }
    else {
      AppUtils.showAlert(result.1!.messages[0], view: self)
    }
  }
  
  func goToSendRequestView() {
    AppData.EnquiryProcess = 2
    navigationController?.popViewControllerAnimated(false)
    
    //performSegueWithIdentifier(AppConstants.Segues.ShowEnquiryView, sender: self)
  }
}
