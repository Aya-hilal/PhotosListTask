//
//  PhotosListViewModel.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation

class PhotosListViewModel: BaseViewModel, ObservableObject {
    var photosList: Observable<[Photo]?> = Observable(nil)
    let limit = 10
    private var pageNumber = 1
    private var canFetchMorePhotos: Bool = true
    private var fromPagination: Bool = false
    
    func getCanFetchMorePhotos() -> Bool {
        return canFetchMorePhotos
    }
    func getFromPagination() -> Bool {
        return fromPagination
    }
    
    func startFetchingPhotosList() {
        pageNumber = 1
        fromPagination = false
        getPhotosList()
    }
    
    func loadMorePhotos() {
        pageNumber += 1
        self.fromPagination = true
        getPhotosList()
    }
    
    private func getPhotosList() {
        PhotosAPI.getPhotosList(pageNumber: pageNumber, limit: limit, completion: { photos, error in
            if photos?.isEmpty ?? true {
                self.canFetchMorePhotos = false
            } else {
                self.canFetchMorePhotos = true
            }
            self.photosList.value = photos
        })
    }
}
