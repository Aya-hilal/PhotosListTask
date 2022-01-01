//
//  PhotosListViewModel.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation

class PhotosListViewModel: BaseViewModel, ObservableObject {
    var photosList: Observable<[Photo]?> = Observable(nil)
    
    func getPhotosList() {
        PhotosAPI.getPhotosList(pageNumber: 1, limit: 10, completion: { photos, error in
            self.photosList.value = photos
        })
    }
}
