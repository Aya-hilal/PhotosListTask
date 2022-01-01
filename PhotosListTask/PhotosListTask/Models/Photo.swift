//
//  Photo.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation

struct Photo: Decodable, Equatable {
    var id: String
    var author: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case url = "url"
    }
}
