//
//  NetworkConnectionManager.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import  Alamofire

class NetworkConnectionManager {
    
    static var sharedInstance = NetworkConnectionManager()
    
    static var IS_CONNECTED_TO_INTERNET: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
