//
//  BreedsViewController.swift
//  UISearchController
//
//  Created by Bo Yang on 15/09/2015.
//  Copyright (c) 2015 PetHomeStay. All rights reserved.
//
import UIKit

protocol BreedsViewControllerDelegate
{
  func breedsViewControllerResponse(parameter: String)
}
/**
  * Table View Controller used for Picking the Breed of a Dog when creating a new Pet.
  */
class BreedsViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {
  
  var delegate:BreedsViewControllerDelegate?
  
  //Breeds Table View UI Mapping
  @IBOutlet var tableView: UITableView!
  
  //Breeds Arrays
  var breeds = [DogBreed]() //All Breeds
  var filteredBreeds = [DogBreed]() //Filtered Breeds
  
  //UISearchController
  var searchController:UISearchController!
  
  //OnViewLoad
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    breeds = AppData.DogBreeds
    
    //Create a new Search Controller
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.sizeToFit()
    searchController.searchBar.tintColor = UIColor.whiteColor()
    searchController.searchBar.barTintColor = AppConstants.Colors.Orange
    
    tableView.tableHeaderView = searchController.searchBar
    definesPresentationContext = true
    
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
  }
  
  // Update searching results
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    
    let searchText = searchController.searchBar.text
    filterContentForSearchText(searchText!)
    tableView.reloadData()
  }
  
  //MARK: -Table View
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (!searchController.searchBar.text!.isEmpty){
      return self.filteredBreeds.count
    }
    else {
      return self.breeds.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
    
    var breed: DogBreed
    
    if (!searchController.searchBar.text!.isEmpty){
      breed = self.filteredBreeds[indexPath.row]
    }
    else {
      breed = self.breeds[indexPath.row]
    }
    
    cell.textLabel?.text = breed.name
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    var breed: DogBreed
    
    if (!searchController.searchBar.text!.isEmpty){
      breed = self.filteredBreeds[indexPath.row]
    }
    else {
      breed = self.breeds[indexPath.row]
    }
    
    print(breed.name)
    
    self.delegate?.breedsViewControllerResponse(breed.name)
    self.navigationController?.popViewControllerAnimated(true)
    //self.dismissViewControllerAnimated(true, completion: {})
  }
  
  
  //MARK: -Search
  
  func filterContentForSearchText(searchText: String, scope: String = "Title")
  {
    self.filteredBreeds = self.breeds.filter({(breed : DogBreed) -> Bool in
      
      let categoryMatch = (scope == "Title")
      let stringMatch = breed.name.lowercaseString.rangeOfString(searchText.lowercaseString)
      
      return categoryMatch && (stringMatch != nil)
      
    })
  }
  
  func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchString searchString: String!) -> Bool {
    self.filterContentForSearchText(searchString, scope: "Title")
    return true
  }
  
  func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
    self.filterContentForSearchText(self.searchController!.searchBar.text!, scope: "Title")
    return true
  }
}


