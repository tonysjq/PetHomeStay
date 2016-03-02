//
//  MapViewController.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 24/08/2015.
//  Copyright (c) 2015 Pet Home Stay. All rights reserved.
//
import UIKit
import MapKit

/**
  * MapView of the Host Results after performing a search.
  */
class ResultsMapViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet var mapView: MKMapView!
  
  let regionRadius: CLLocationDistance = 1200
  
  var postcode : String?
  var homestays = [Homestay]()
  var latitude : Double?
  var longitude : Double?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Which Location shall we display by default?
    let initialLocation = CLLocation(latitude: -37.8136111, longitude: 144.9630556)
    
    centerMapOnLocation(initialLocation)
    mapView.delegate = self
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
      regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  func refreshData() {
    mapView.removeAnnotations(mapView.annotations)
    
    var annotation : PHSMapAnnotation
    
    var mapPosition = CLLocation(latitude: -37.8136111, longitude: 144.9630556) //Melbourne by default.
    var shortestDistance = 1000.0
    
    for homestay in homestays {
      if (homestay.distance < shortestDistance) {
        mapPosition = CLLocation(latitude: homestay.location.latitude, longitude: homestay.location.longitude)
        shortestDistance = homestay.distance
      }
      
      print("Position: \(homestay.location.latitude) : \(homestay.location.longitude)")
      
      //Create Annotation
      annotation = PHSMapAnnotation()
      annotation.coordinate =  CLLocationCoordinate2DMake(homestay.location.latitude, homestay.location.longitude)
      annotation.title = homestay.host.firstName
      annotation.subtitle = homestay.title
      annotation.imageName = "MapMarker"
      mapView.addAnnotation(annotation)
    }
    
    centerMapOnLocation(mapPosition)
  }
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    if !(annotation is PHSMapAnnotation) {
      return nil
    }
    
    let reuseId = "hostAnnotation"
    
    var allocatedAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
    if allocatedAnnotationView == nil {
      allocatedAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      allocatedAnnotationView!.canShowCallout = true
    }
    else {
      allocatedAnnotationView!.annotation = annotation
    }
    
    let mapAnnotation = annotation as! PHSMapAnnotation
    allocatedAnnotationView!.image = UIImage(named:mapAnnotation.imageName)
    
    return allocatedAnnotationView
  }
  
  func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
    self.performSegueWithIdentifier("ShowResults", sender: self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}