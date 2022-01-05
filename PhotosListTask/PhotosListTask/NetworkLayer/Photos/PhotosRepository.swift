//
//  PhotoRepository.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 05/01/2022.
//

import Foundation

struct PhotosRepository: PhotosDataSource {
    private let remoteDataSource: PhotosAPI
    private let localDataSource: PhotosLocalDataSource
    
    public init() {
        self.remoteDataSource = PhotosAPI()
        self.localDataSource = PhotosLocalDataSource()
    }
    
    func getPhotosList(pageNumber: Int, limit: Int, completion: @escaping ([Photo]?, APIError?) -> Void) {
        remoteDataSource.getPhotosList(pageNumber: pageNumber, limit: limit) { photosResults, error in
            if let result = photosResults {
                if pageNumber == 1 || pageNumber == 2 {
                    localDataSource.savePhotosList(photos: result)
                }
                completion(result, nil)
            }
            if let error = error {
                if pageNumber == 1 || pageNumber == 2 {
                    let localPhotos = localDataSource.getLocalPhotosList(pageNumber: pageNumber)
                    if !localPhotos.isEmpty {
                        completion(localPhotos, nil)
                    }
                } else {
                 completion(nil, error)
                }
            }
        }
    }
}
