//
//  PhotoDetailsViewModel.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 03/01/2022.
//

import Foundation

class PhotoDetailsViewModel: BaseViewModel {
    
    init(photo: Photo?) {
        self.photo = photo
    }
    
    //MARK: - Propertires
    private var photo: Photo?
    
    
    // MARK: - Methods
    func getPhoto() -> Photo? {
        return photo
    }
    
}
