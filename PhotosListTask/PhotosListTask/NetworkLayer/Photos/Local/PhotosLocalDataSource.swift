//
//  UserLocalDataSource.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 05/01/2022.
//

import Foundation

class PhotosLocalDataSource {
   
    func savePhotosList(photos: [Photo]) {
        for photo in photos {
         PersistDataManager.shared.saveObject(photo)
        }
    }
    
    func getLocalPhotosList(pageNumber: Int) -> [Photo] {
        let photos = PersistDataManager.shared.getObjects(Photo.self)
        if photos.count >= (pageNumber * 10) {
            let slice = photos[((pageNumber - 1) * 10)..<(pageNumber * 10)]
            return getPhotosListFromRealm(slice)
        } else {
            return []
        }
    }
    
     private func getPhotosListFromRealm(_ realmPhotos: ArraySlice<RealmPhoto>) -> [Photo] {
        var photos: [Photo] = []
        for realmPhoto in realmPhotos {
            photos.append(Photo(managedObject: realmPhoto))
        }
        return photos
    }
    
}
