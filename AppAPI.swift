//
//  AppAPI.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 27/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//

import Foundation


/**
  * Utility Class holding everything regarding the API.
  * API Constants, Login Functions, POST and GET Requests.
  */
class AppAPI {
  
  //# MARK: API Constants
  static let PET_HOME_STAY_STATING = "https://pethomestay-staging.herokuapp.com/api/"
  static let TOKEN_STAGING = "/?token=a8f7cb9c-6344-42e2-8438-c689f9f29c65&"
  
  static let PET_HOME_STAY_DEV = "https://puppies:puppies@pethomestay-staging.herokuapp.com/api/"
  static let TOKEN = "a8f7cb9c-6344-42e2-8438-c689f9f29c65"
  static let TOKEN_DEV = "?token=" + TOKEN
  
  //Private constructor. Instance not required.
  private init () {
    
  }
  
  /**
  * Utility method to Authenticate to the App using Email and Password.
  */
  class func Authenticate(email: String, password: String) -> (User?, Error?) {
    let request = AppAPI.getLoginRequest(email, password: password)
    var response: NSURLResponse? = nil
    var error: NSError?
    let reply: NSData?
    do {
      reply = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
    } catch let error1 as NSError {
      error = error1
      print(error)
      reply = nil
    }
    let result = JSON(data:reply!)
    
    let userJson = result["user"]
    
    if userJson != nil
    {
      let user = JsonObjectFactory.parseUserFromLogin(userJson)
      
      return (user, nil)
    }
    else {
      return (nil, JsonObjectFactory.parseError(result["error"]))
    }
  }
  
  class func LoginIntoPHSThroughFacebook() {
    //If the user hasn't login through facebook, return.
    if (FBSDKAccessToken.currentAccessToken() == nil) {
      return
    }
    
    //When user is logged in with Facebook. Retrieve first name, last name and email to do PHS Authentication.
    
    /* THIS IS THE REAL PROCESS! */
    
    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,first_name,last_name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
    req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
      if(error == nil)
      {
        var user : User?
        var innerError : Error?
        
        let email = result.valueForKey("email") as! String
        let firstName = result.valueForKey("first_name") as! String
        let lastName = result.valueForKey("last_name") as! String
        
        //Try to Login into PHS first!
        let oauth = Oauth(provider: "facebook", token: FBSDKAccessToken.currentAccessToken().userID)
        let loginObject = CreateLoginObject(email: email, password: nil, device: nil, oauth: oauth)
        
        (user, innerError) = LoginWithFacebook(loginObject.toJson())
        
        if (user != nil) {
          print("Logged in!")
          print(user?.toDictionary())
        }
        else {
          print("Couldn't Log In With Facebook...")
          print(innerError?.messages[0])
          
          //Couldn't Login, Then Create an Account using Facebook:
          let userAccount = UserAccount(firstName: firstName, lastName: lastName, email: email, password: "")
          let signupObject = CreateSignupObject(user: userAccount, device: nil, oauth: oauth)
          
          (user, innerError) = AppAPI.getCreateAccountRequest(signupObject.toJson())
          
          if (user != nil) {
            print("Account Created!")
            print(user)
          }
          else {
            print("Couldnt Create a PHS Account!")
            print(innerError?.messages[0])
          }
        }
      }
      else
      {
        //There was an error performing the GraphAPI call.
        print("There was en error using the Facebook Graph API: \(error)")
      }
    })
    /*
    
    //TODO DELETE ME! Just TESTING METHODS WHEN NO DEVICE IS AVAILABLE!
    //let firstName = "Juan"
    //let lastName = "Delgado"
    let email = "jddelgadov@gmail.com"
    
    //let userAccount = UserAccount(firstName: firstName, lastName: lastName, email: email, password: "")
    let oauth = Oauth(provider: "facebook", token: FBSDKAccessToken.currentAccessToken().userID)
    //let test2 = CreateDeviceObject(name: "\(firstName)'s iPhone", token: AppData.DeviceToken!)
    //let device = Device(name: "Juan's Phone", token: "asdsadasdsadasasd")
    //let signupObject = CreateSignupObject(user: userAccount, device: nil, oauth: oauth)
    let loginObject = CreateLoginObject(email: email, password: nil, device: nil, oauth: oauth)
    
    let user : User?
    let error : Error?
    
    print("Login Object to Dictionary: ")
    print(loginObject.toDictionary())
    
    (user, error) = loginWithFacebook(loginObject.toJson())
    
    if (user != nil) {
      print("Logged in!")
      print(user?.toDictionary())
    }
    else {
      print("Account Could not be created")
      print(error)
    }
    */
  }
  
  //# MARK: - AppAPI Methods
  class func getHomestays(postcode :String, latitude :String?, longitude :String?) -> NSMutableURLRequest {
    let homestays = "homestays"
    
    //Build URL
    var URL = buildBasicGetURL(homestays)
    URL += "&postcode=\(postcode)"
    
    return getRequest(URL)
  }
  
  class func getBasicAppDataRequest() -> NSMutableURLRequest {
    let URL = PET_HOME_STAY_DEV + TOKEN_DEV
    return getRequest(URL)
  }
  
  class func getLoginRequest(email: String, password: String) -> NSMutableURLRequest {
    let parameters = "email="+email+"&password="+password
    
    let endPoint = "sessions"
    
    let URL = buildBasicPostURL(endPoint)
    return postRequest(URL, parameters: parameters)
  }
  
  class func getCreateAccountRequest(object: NSData?) -> (User?, Error?) {
    let endPoint = "users"
    
    let URL = buildBasicPostURL(endPoint)
    
    let request = postRequest(URL, object: object)
    
    var response: NSURLResponse? = nil
    var error: NSError?
    let reply: NSData?
    do {
      reply = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
    } catch let error1 as NSError {
      error = error1
      print(error) //#TODO: - JDDV Do Error Handling
      reply = nil
    }
    let results = JSON(data: reply!)
    
    let accountJson = results["user"]
    
    if (accountJson != nil) {
      return (JsonObjectFactory.parseUserFromLogin(accountJson), nil)
    }
    else {
      return (nil, JsonObjectFactory.parseError(results["error"]))
    }
  }
  
  private class func LoginWithFacebook(object: NSData?) -> (User?, Error?) {
    let endPoint = "sessions"
    
    let URL = buildBasicPostURL(endPoint)
    
    let request = postRequest(URL, object: object)
    
    var response: NSURLResponse? = nil
    var error: NSError?
    let reply: NSData?
    do {
      reply = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
    } catch let error1 as NSError {
      error = error1
      print(error) //#TODO: - Do Error Handling
      reply = nil
    }
    let results = JSON(data: reply!)
    
    let accountJson = results["user"]
    
    if (accountJson != nil) {
      return (JsonObjectFactory.parseUserFromLogin(accountJson), nil)
    }
    else {
      return (nil, JsonObjectFactory.parseError(results["error"]))
    }
  }
  
  class func getCreatePetRequest(object: NSData?) -> (Pet?, Error?) {
    let endPoint = "pets"
    
    let URL = buildBasicPostURL(endPoint)
    
    let request = postRequest(URL, object: object)
    
    var response: NSURLResponse? = nil
    var error: NSError?
    let reply: NSData?
    do {
      reply = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
    } catch let error1 as NSError {
      error = error1
      print(error) //#TODO: - JDDV Do Error Handling
      reply = nil
    }
    let results = JSON(data: reply!)
    
    let accountJson = results["pet"]
    
    if (accountJson != nil) {
      return (JsonObjectFactory.parsePet(accountJson), nil)
    }
    else {
      return (nil, JsonObjectFactory.parseError(results["error"]))
    }
  }
  
  class func getPetsRequest(userToken: String) -> NSURLRequest {
    let parameters = "&user_token=\(userToken)"
    
    let endPoint = "pets"
    
    let URL = buildBasicGetURL(endPoint) + parameters
    
    return getRequest(URL)
  }
  
  class func getPetsFromUser(userToken: String) -> ([Pet]?,Error?) {
    let request = getPetsRequest(userToken)
    
    var response: NSURLResponse? = nil
    var error: NSError?
    let reply: NSData?
    do {
      reply = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
    } catch let error1 as NSError {
      error = error1
      print(error) //#TODO: - JDDV Do Error Handling
      reply = nil
    }
    let result = JSON(data:reply!)
    
    let petsJson = result["pets"]
    
    if petsJson != nil
    {
      let pet = JsonObjectFactory.parsePets(petsJson)
      
      return (pet, nil)
    }
    else {
      return (nil, JsonObjectFactory.parseError(result["error"]))
    }
  }

  //# MARK: - Private Convenient API Methods
  private class func getRequest(URL :String) -> NSMutableURLRequest {
    let request : NSMutableURLRequest = NSMutableURLRequest()
    request.URL = NSURL(string: URL)
    request.HTTPMethod = "GET"
    return request
  }
  
  private class func postRequest(URL: String, parameters: String) -> NSMutableURLRequest {
    let request = postBasicRequest(URL)
    
    let requestBodyDate = (parameters as NSString).dataUsingEncoding(NSUTF8StringEncoding)
    request.HTTPBody = requestBodyDate
    
    return request
  }
  
  private class func postRequest(URL: String, object: NSData?) -> NSMutableURLRequest {
    let request = postBasicRequest(URL)
    
    //Add Content to HTTP Body
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = object
    
    return request
  }
  
  private class func postBasicRequest(URL: String) -> NSMutableURLRequest {
    let request : NSMutableURLRequest = NSMutableURLRequest()
    request.URL = NSURL(string: URL)
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
    request.timeoutInterval = 2.0
    request.HTTPMethod = "POST"
    
    //Set Content Type and Boundary
    let boundaryConstant = "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy";
    let contentType = "multipart/form-data; boundary=" + boundaryConstant
    NSURLProtocol.setProperty(contentType, forKey: "Content-Type", inRequest: request)
    return request
  }
  
  //Basic Get URL
  private class func buildBasicGetURL(endPoint :String) -> String {
    return (PET_HOME_STAY_DEV + endPoint + "/" + TOKEN_DEV)
  }
  
  //Basic Post URL
  private class func buildBasicPostURL (endPoint :String) -> String {
    return (PET_HOME_STAY_DEV + endPoint + TOKEN_DEV)
  }
}