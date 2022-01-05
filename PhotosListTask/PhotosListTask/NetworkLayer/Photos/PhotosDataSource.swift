//
//  PhotoDataSource.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 05/01/2022.
//

import Foundation

protocol PhotosDataSource {
    func getPhotosList(pageNumber: Int, limit: Int, completion: @escaping ([Photo]?, APIError?) -> Void)
}
