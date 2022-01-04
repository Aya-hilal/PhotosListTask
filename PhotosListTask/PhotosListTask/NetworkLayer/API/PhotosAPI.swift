//
//  PhotosAPI.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation

class PhotosAPI: BaseAPI {
    static func getPhotosList(pageNumber: Int, limit: Int, completion: @escaping ([Photo]?, APIError?) -> Void) {
        request(request: PhotosRouter.getPhotosList(pageNumber: pageNumber, limit: limit), responseType: [Photo].self, showDefaultErrorSnackbar: false) { result, error  in
            if let result = result {
                if pageNumber == 1 || pageNumber == 2 {
                    for photo in result {
                     PersistDataManager.shared.saveObject(photo)
                    }
                }
                completion(result, nil)
            }
            if let error = error {
                if pageNumber == 1 || pageNumber == 2 {
                    let localPhotos = getLocalPhotosList(pageNumber: pageNumber)
                    if !localPhotos.isEmpty {
                        completion(localPhotos, nil)
                    }
                } else {
                 completion(nil, error)
                }
            }
        }
    }
    
    static func getLocalPhotosList(pageNumber: Int) -> [Photo] {
        let photos = PersistDataManager.shared.getObjects(Photo.self)
        if photos.count >= (pageNumber * 10) {
            let slice = photos[((pageNumber - 1) * 10)..<(pageNumber * 10)]
            return getPhotosListFromRealm(slice)
        } else {
            return []
        }
    }
    
    static private func getPhotosListFromRealm(_ realmPhotos: ArraySlice<RealmPhoto>) -> [Photo] {
        var photos: [Photo] = []
        for realmPhoto in realmPhotos {
            photos.append(Photo(managedObject: realmPhoto))
        }
        return photos
    }
    
}
