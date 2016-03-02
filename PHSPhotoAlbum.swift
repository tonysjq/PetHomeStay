//
//  PHSPhotoAlbum.swift
//  PetHomeStay
//
//  Created by Shuaiji Qian on 15/10/29.
//  Copyright © 2015年 Pet Home Stay. All rights reserved.
//

import Photos

class PHSPhotoAlbum {
  
  static let albumName = "PetHomeStay"
  static let sharedInstance = PHSPhotoAlbum()
  
  var assetCollection: PHAssetCollection!
  
  init() {
    
    func fetchAssetCollectionForAlbum() -> PHAssetCollection! {
      
      let fetchOptions = PHFetchOptions()
      fetchOptions.predicate = NSPredicate(format: "title = %@", PHSPhotoAlbum.albumName)
      let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
      
      if  (collection.firstObject != nil) {
        return collection.firstObject as! PHAssetCollection
      }
      
      return nil
    }
    
    if let assetCollection = fetchAssetCollectionForAlbum() {
      self.assetCollection = assetCollection
      return
    }
    
    PHPhotoLibrary.sharedPhotoLibrary().performChanges({
      PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(PHSPhotoAlbum.albumName)
      }) { success, _ in
        if success {
          self.assetCollection = fetchAssetCollectionForAlbum()
        }
    }
  }
  
  func CreateAlbum() {
    //Album will be created as soon as PHSPhotoAlbum.sharedInstance gets called.
    print("Creating PHS Album")
  }
  
  
  func saveImage(image: UIImage) {

    if assetCollection == nil {
      return   // If there was an error upstream, skip the save.
    }
    
    PHPhotoLibrary.sharedPhotoLibrary().performChanges({
      let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
      let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
      let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
      albumChangeRequest!.addAssets([assetPlaceholder!])
      }, completionHandler: nil)
  
    
    
    }

  
  
  
}
