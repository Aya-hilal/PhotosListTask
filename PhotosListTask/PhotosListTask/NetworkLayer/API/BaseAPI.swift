//
//  BaseAPI.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import Alamofire

class BaseAPI {
    static func request<T: Decodable>(request: URLRequestConvertible, responseType: T.Type, showDefaultErrorSnackbar: Bool, completion: @escaping ((T?, APIError?) -> ())) {
        
        guard NetworkConnectionManager.IS_CONNECTED_TO_INTERNET else {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: BaseViewModel.networkMessageKey),
                object: "Global.network_reachability_error"
            )
            completion(nil, APIError.connectionError)
            return
        }
        
        AF.request(request).validate().responseDecodable(of: T.self, queue: .main) { afResponse in
            
            var returnedError: APIError?
            var returnedResponse: T?
            
            switch afResponse.result {
            
                case .failure(_):
                    if let httpResponse = afResponse.response {
                        returnedError = handleAPIError(httpResponse: httpResponse, responseData: afResponse.data)
                        if showDefaultErrorSnackbar {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: BaseViewModel.networkMessageKey), object: returnedError?.message)
                        }
                    }
                case .success(let value):
                    returnedResponse = value
            }
            completion(returnedResponse, returnedError)
        }
    }
    
    static func handleAPIError(httpResponse: HTTPURLResponse, responseData: Data?) -> APIError? {
        if httpResponse.statusCode == 401 ||  httpResponse.statusCode == 400 || httpResponse.statusCode == 405 || httpResponse.statusCode == 404 || httpResponse.statusCode == 500
            || httpResponse.statusCode == 422 {
            
            var apiError: APIError? = nil
            if let data  = responseData {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    if let errors = json?["meta"] as? [String: String], !errors.isEmpty {
                            apiError = APIError(customError: errors["message"])
                    }
                } catch {
                    print("error: \(error)")
                }
            }
            //
            if apiError == nil {
                apiError = APIError(responseCode: httpResponse.statusCode)
            }
            return apiError
        }
        return .errorOccured
    }
}

enum APIError: Error {
    init() {
        self = .errorOccured
    }
    init(error: AFError? = nil, responseCode: Int? = nil, customError: String? = nil) {
        
        if customError != nil {
            self = .custom(customError ?? "")
        } else {
            var code = responseCode
            if error != nil {
                code = error!.responseCode
            }
            switch code {
            case 500:
                self = .serverError
            case 401:
                self = .authorizationError
            case 404:
                self = .notFound
            default:
                self = .errorOccured
            }
        }
    }
    
    case errorOccured
    case connectionError
    case notFound
    case authorizationError
    case custom(String)
    case serverError
    
    var message: String {
        switch self {
        case .serverError:
            return "Internal Server error"
        case .errorOccured:
            return "An error has occured"
        case .custom(let message):
            return message
        case .connectionError:
            return "Error connecting to the Internet"
        case .notFound:
            return "Not found error has occurred"
        case .authorizationError:
            return "An authentication error has occurred"
        }
    }
}
