//
//  PhotosRouter.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import Alamofire

enum PhotosRouter: BaseRouter {
    case getPhotosList(pageNumber: Int, limit: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getPhotosList:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getPhotosList(let pageNumber, let limit):
            return "\(Paths.listPage)\(pageNumber)\(Paths.limit)\(limit)"
        }
    }
    
    struct Paths {
        static let listPage = "/list?page="
        static let limit = "&limit="
    }
}
