//
//  SignupViewController.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 25/8/25.
//  Copyright (c) 2015年 Pet Home Stay. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignupViewController: FacebookLoginViewController{
  //# MARK: - View Outlets
  @IBOutlet var stepsImage: UIImageView!
  
  @IBOutlet var backgroundImage: UIImageView!
  @IBOutlet var facebookLoginButton: FBSDKLoginButton!
  
  @IBOutlet var joinusButton: UIButton!
  @IBOutlet var loginButton: UIButton!
  
  @IBOutlet var OrLabel: UILabel!
  @IBOutlet var byjoinLabel: UILabel!
  @IBOutlet var notamemberLabel: UILabel!
  @IBOutlet var AlreadyLabel: UILabel!
  @IBOutlet var whiteImage: UIImageView!
  @IBOutlet var termsButton: UIButton!
  @IBOutlet var smallsignupButton: UIButton!
  
  //Containers
  @IBOutlet var signupContainer: UIView!
  @IBOutlet var loginContainer: UIView!
  
  @IBOutlet weak var bigloginButton: UIButton!
  
  @IBOutlet var Step3SendEnquiryLabel: UILabel!
  @IBOutlet var Step2PetDetailsLabel: UILabel!
  @IBOutlet var Step1JoinUsLabel: UILabel!
  
  @IBOutlet var petHomeStayLogo: UIImageView!
  
  var FBFrame:CGRect!
  var joinusFrame:CGRect!
  var loginFrame:CGRect!
  var orlabelFrame:CGRect!
  var alreadyFrame:CGRect!
  var  signupViewController: SignupContainer?
  var loginViewController: LoginContainer?
  var countjoinuspressed=0
  var countloginpressed=0
  
  var comingFromTabBar = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if (comingFromTabBar) {
      stepsImage.hidden = true
      Step3SendEnquiryLabel.hidden = true
      Step2PetDetailsLabel.hidden = true
      Step1JoinUsLabel.hidden = true
      whiteImage.hidden = true
      
      backgroundImage.image = UIImage(named: "NewBackground")
    }
    else {
      petHomeStayLogo.hidden = true
    }
    
    //add tag to the button
    loginButton.tag=1
    smallsignupButton.tag=2
    joinusButton.tag=3
    bigloginButton.tag=4
    //Tag anywhere else, hide keyboard.
    termsButton.hidden=false
    byjoinLabel.hidden=false
    termsButton.hidden=true
    smallsignupButton.hidden=true
    notamemberLabel.hidden=true
    
    for childController in self.childViewControllers {
      if (childController is SignupContainer) {
        signupViewController = (childController as! SignupContainer)
      }
      else if (childController is LoginContainer) {
        loginViewController = (childController as! LoginContainer)
      }
    }
    
    
    //hide the two container
    signupContainer.hidden = true
    loginContainer.hidden = true
    byjoinLabel.hidden=true
    
    bigloginButton.hidden=true
    bigloginButton.backgroundColor = AppConstants.Colors.Orange
    joinusButton.backgroundColor = AppConstants.Colors.Orange
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
    view.addGestureRecognizer(tap)
    //The small two buttons in the same position
    loginButton.addTarget(self, action: "loginAction:", forControlEvents: UIControlEvents.TouchUpInside)
    smallsignupButton.addTarget(self, action: "loginAction:", forControlEvents:
      UIControlEvents.TouchUpInside)
    
    
    //The two big green buttons in the same position
    joinusButton.addTarget(self, action: "joinusAction:", forControlEvents:
      UIControlEvents.TouchUpInside)
    bigloginButton.addTarget(self, action: "joinusAction:", forControlEvents:
      UIControlEvents.TouchUpInside)
    
    //Login View Container Events
    loginViewController!.email.addTarget(self, action: "loginviewtextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    loginViewController!.password.addTarget(self, action: "loginviewtextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    
    //Signup View Container Events
    signupViewController!.firstNameTextField.addTarget(self, action: "signupviewtextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    signupViewController!.lastNameTextField.addTarget(self, action: "signupviewtextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    signupViewController!.emailTextField.addTarget(self, action: "signupviewtextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    signupViewController!.passwordTextField.addTarget(self, action: "signupviewtextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    
    
    bigloginButton.enabled = false
    bigloginButton.backgroundColor = UIColor.lightGrayColor()
  }
  
  func movetheviewforsignup()
  {
    
    // move view to center of screen
    let FBFrame=facebookLoginButton.frame
    let joinusFrame=joinusButton.frame
    let loginFrame=loginButton.frame
    let orlabelFrame=OrLabel.frame
    let alreadyFrame=AlreadyLabel.frame
    print(FBFrame.origin.y,joinusFrame.origin.y,loginFrame.origin.y,orlabelFrame.origin.y,alreadyFrame.origin.y, terminator: "")
    
    facebookLoginButton.frame.origin.y=241-25
    
    OrLabel.frame.origin.y = 338-65
    
    //these two button has same position
    bigloginButton.frame.origin.y=396+50
    joinusButton.frame.origin.y=396+50
    
    
    //these two label have same position
    notamemberLabel.frame.origin.y=439+70
    AlreadyLabel.frame.origin.y=439+70
    
    //these two button have same position
    smallsignupButton.frame.origin.y=435+70
    loginButton.frame.origin.y=435+70
    
    /*Increase size
    facebookLoginButton.frame.origin.y=FBFrame.origin.y-25
    joinusButton.frame.origin.y=joinusFrame.origin.y+50
    loginButton.frame.origin.y=loginFrame.origin.y+70
    OrLabel.frame.origin.y = orlabelFrame.origin.y-65
    AlreadyLabel.frame.origin.y=alreadyFrame.origin.y+70
    smallsignupButton.frame.origin.y+=70*/
    
  }
  
  func movetheviewforlogin()
  {
    
    facebookLoginButton.frame.origin.y=241-27+20
    
    OrLabel.frame.origin.y = 338-65+10
    
    //these two button has same position
    bigloginButton.frame.origin.y=396+50-15
    joinusButton.frame.origin.y=396+50-15
    
    
    notamemberLabel.frame.origin.y=439+70-35
    AlreadyLabel.frame.origin.y=439+70-35
    
    smallsignupButton.frame.origin.y=435+70-35
    loginButton.frame.origin.y=435+70-35
    
    
  }
  
  //The animation of login button not work properly now
  //login function
  func loginAction(sender: UIButton!) {
    //performSegueWithIdentifier("Login", sender: sender)
    countloginpressed=countloginpressed+1
    if (sender.tag==1){
      signupContainer.hidden=true
      termsButton.hidden=true
      byjoinLabel.hidden=true
      loginButton.hidden=true
      smallsignupButton.hidden=false
      AlreadyLabel.hidden=true
      notamemberLabel.hidden=false
      joinusButton.hidden=true
      bigloginButton.hidden=false
      UIView.animateWithDuration(1, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveLinear, animations: {
        self.movetheviewforlogin()
        
        }, completion:{ finished in
          UIView.animateWithDuration(0.1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveLinear, animations: {
            self.loginContainer.hidden=false
            
            }, completion: nil)})
    }
    else
    {
      loginContainer.hidden = true
      AlreadyLabel.hidden=false
      notamemberLabel.hidden=true
      smallsignupButton.hidden=true
      loginButton.hidden=false
      joinusButton.hidden=false
      bigloginButton.hidden=true
      joinusButton.enabled = false
      joinusButton.backgroundColor = UIColor.lightGrayColor()
      
      UIView.animateWithDuration(1, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveLinear, animations: {
        
        self.movetheviewforsignup()
        
        }, completion:{ finished in
          UIView.animateWithDuration(0.1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveLinear, animations: {
            self.signupContainer.hidden=false
            
            self.termsButton.hidden=false
            self.byjoinLabel.hidden=false
            }, completion: nil)})
      
    }
    
  }
  
  
  @IBAction func openTermsAndConditions(sender: UIButton) {
    UIApplication.sharedApplication().openURL(NSURL(string:"http://support.pethomestay.com.au/hc/en-us/articles/201214939-Terms-Conditions")!)
  }
  
  
  func joinusAction(sender:UIButton!)
    
  {  //sign up view without the textfield
    if (sender.tag==3&&countjoinuspressed==0&&countloginpressed==0)
    {    countjoinuspressed=countjoinuspressed+1
      self.loginContainer.hidden = true
      UIView.animateWithDuration(1, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveLinear, animations: {
        self.joinusButton.enabled = false
        self.joinusButton.backgroundColor = UIColor.lightGrayColor()
        self.movetheviewforsignup()
        
        }, completion:{ finished in
          UIView.animateWithDuration(0.1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveLinear, animations: {
            self.signupContainer.hidden=false
            self.termsButton.hidden=false
            self.termsButton.hidden=false
            self.byjoinLabel.hidden=false
            
            }, completion: nil)})
      
    }
      //sign up view
    else if (sender.tag==3&&(countjoinuspressed>0||countloginpressed>0))
    {
      
      //MARK to do put some code to sign up
      let firstname=signupViewController!.firstNameTextField.text!
      let lastname=signupViewController!.lastNameTextField.text!
      let email=signupViewController!.emailTextField.text!
      let passwd=signupViewController!.passwordTextField.text!
      
      
      //check email format and password
      let pass=checkemailandpasswd(email, passwd:passwd)
      if pass==true
      {//sign up request
        let user = User(firstName: firstname, lastName: lastname, email: email, password: passwd)
        print(user.toJson(false))
        
        let result = AppAPI.getCreateAccountRequest(user.toJson(false))
      
        if (result.0 != nil) {

          let userDefaults = NSUserDefaults.standardUserDefaults()
          userDefaults.setValue(result.0!.id, forKey: AppUserDefaultsConstants.UserId)
          userDefaults.setValue(result.0!.token, forKey: AppUserDefaultsConstants.UserToken)
          
          AppData.UserToken = result.0!.token
          
          if (comingFromTabBar) {
            self.navigationController?.popViewControllerAnimated(true)
            return
          }
          
          performSegueWithIdentifier(AppConstants.Segues.ShowPetDetailsView, sender: self)
        }
        else {
          AppUtils.showAlert(result.1!.messages[0], view: self)
        }
      }
    }
      //log in view
      
    else if (sender.tag==4)
    {
      termsButton.hidden=true
      byjoinLabel.hidden=true
      let email=loginViewController!.email.text!
      let passwd=loginViewController!.password.text!
      
      let check=checkemailandpasswd(email,passwd:passwd)
      
      if check==true
      {
        let user : User?
        var error : Error?
        
        (user, error) = AppAPI.Authenticate(email, password: passwd)
        
        if (user != nil) {
          let userDefaults = NSUserDefaults.standardUserDefaults()
          userDefaults.setValue(user!.id, forKey: AppUserDefaultsConstants.UserId)
          userDefaults.setValue(user!.token, forKey: AppUserDefaultsConstants.UserToken)
          AppData.UserToken = user!.token
          
          let navigationController = self.navigationController!
          
          
          if (comingFromTabBar) {
            self.navigationController?.popViewControllerAnimated(true)
            return
          }
          
          //Check for Pets
          var pets : [Pet]?
          
          
          (pets, error) = AppAPI.getPetsFromUser(user!.token!)
          
          if error != nil {
            AppUtils.showAlert(error!.messages[0], view: self)
          }

          if (pets!.isEmpty) {
            AppData.EnquiryProcess = 1
            navigationController.popViewControllerAnimated(false)
          }
          else {
            AppData.EnquiryProcess = 2
            navigationController.popViewControllerAnimated(false)
          }
        }
        else if (error != nil) {
          AppUtils.showAlert(error!.messages[0], view: self)
        }
      }
    }
  }
  
  //check email format and password length
  func checkemailandpasswd(email:String,passwd:String)->Bool
  {
    var pass=false
    let result = AppUtils.evaluateEmail(email)
    
    if (result == true && passwd.characters.count>=6)
    {
      pass=true
    }
    if result==false
    {
      AppUtils.showAlert("Invalid email format", view: self)
    }
    if passwd.characters.count<6
    {
      AppUtils.showAlert("Password is not long enough", view: self)
    }
    return pass
  }
  
  func DismissKeyboard(){
    view.endEditing(true)
  }
  
  
  
  func signupviewtextFieldDidChange(textField: UITextField){
    if (signupViewController!.emailTextField.text!.isEmpty || signupViewController!.passwordTextField.text!.isEmpty||signupViewController!.firstNameTextField.text!.isEmpty||signupViewController!.lastNameTextField.text!.isEmpty) {
      joinusButton.enabled = false
      joinusButton.backgroundColor = UIColor.lightGrayColor()}
    else
    {
      joinusButton.enabled = true
      joinusButton.backgroundColor = AppConstants.Colors.Orange
    }
  }
  
  func loginviewtextFieldDidChange(textField: UITextField) {
    if (loginViewController!.email.text!.isEmpty || loginViewController!.password.text!.isEmpty) {
      bigloginButton.enabled = false
      bigloginButton.backgroundColor = UIColor.lightGrayColor()
    }
    else {
      bigloginButton.enabled = true
      bigloginButton.backgroundColor = AppConstants.Colors.Orange
    }
  }
  
  
  override func userHasLoggedIn() {
    if (comingFromTabBar) {
      navigationController?.popViewControllerAnimated(true)
    }
    else {
      navigationController?.popViewControllerAnimated(false)
      navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("PetDetailsViewController") , animated: true)
      
    }
    print("TONY LOGGED IN", terminator: "")
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
  override func viewWillAppear(animated: Bool) {
    if (self.tabBarController != nil) {
      self.tabBarController!.tabBar.hidden = true
    }
    
    if (self.navigationController != nil) {
      self.navigationController?.navigationBar.hidden = false
    }
  }
}

extension String
{
  subscript(integerIndex: Int) -> Character {
    let index = startIndex.advancedBy(integerIndex)
    return self[index]
  }
  
  subscript(integerRange: Range<Int>) -> String {
    let start = startIndex.advancedBy(integerRange.startIndex)
    let end = startIndex.advancedBy(integerRange.endIndex)
    let range = start..<end
    return self[range]
  }
}