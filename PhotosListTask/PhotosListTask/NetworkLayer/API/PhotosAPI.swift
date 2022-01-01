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
            completion(result, error)
        }
    }
}
