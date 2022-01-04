//
//  RealmPhoto.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 04/01/2022.
//

import Foundation
import RealmSwift

class RealmPhoto: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var downloadUrl: String = ""
    @objc dynamic var type: Int = DataTypes.photo.hashValue
    
    func setPhoto(with photo: Photo) {
        id = photo.id
        author = photo.author
        url = photo.url
        downloadUrl = photo.downloadUrl
        type = photo.type.hashValue
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
