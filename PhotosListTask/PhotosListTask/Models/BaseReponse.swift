//
//  BaseReponse.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation

struct BaseResponse<T: Decodable & Equatable & Encodable>: Decodable, Encodable, Equatable {
    var results: T?
}
