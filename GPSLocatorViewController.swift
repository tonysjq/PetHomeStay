//
//  GPSLocatorViewController.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 18/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//
import UIKit
import CoreLocation

class GPSLocatorViewController: UIViewController, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler:{(placemarks,error)->Void in
      
      if (error != nil){
        print("Error:" + error!.localizedDescription)
        return
      }
      
      if placemarks!.count>0{
        let pm = placemarks![0]
        self.getLocationInfo(pm)
      }
      else {
        print("Error with data")
        
      }
    })
  }
  
  func getLocationInfo(placemark:CLPlacemark){
    self.locationManager.stopUpdatingLocation()
    
    print(placemark.locality)
    print(placemark.postalCode)
    print(placemark.administrativeArea)
    print(placemark.country)
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error:NSError){
    print("Error:" + error.localizedDescription)
  }
}