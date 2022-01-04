//
//  Photo.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation

enum DataTypes: Int {
    case photo
    case ad
}

struct Photo: Decodable, Equatable, Encodable {
    var id: String
    var author: String
    var url: String
    var downloadUrl: String
    var type: DataTypes = .photo
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case url = "url"
        case downloadUrl = "download_url"
    }
    
    init(type: DataTypes) {
        self.id = ""
        self.author = ""
        self.url = ""
        self.downloadUrl = ""
        self.type = type
    }
}


extension Photo: Persistable {
    
    init(managedObject: RealmPhoto) {
        id = managedObject.id
        author = managedObject.author
        url = managedObject.url
        downloadUrl = managedObject.downloadUrl
        type = DataTypes(rawValue: managedObject.type) ?? .photo
    }
    
    func getManagedObject() -> RealmPhoto {
        let realmPhoto = RealmPhoto()
        realmPhoto.setPhoto(with: self)
        return realmPhoto
    }
}
