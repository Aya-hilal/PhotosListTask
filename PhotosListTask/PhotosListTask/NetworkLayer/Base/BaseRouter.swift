//
//  BaseRouter.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import Alamofire

protocol BaseRouter: URLRequestConvertible {
    var method        : HTTPMethod { get }
    var path          : String { get }
    var extraHeaders  : [String : String] { get }
    var parameters    : Parameters? { get }
}

extension BaseRouter {
    
    var extraHeaders: [String : String] {
        return [:]
    }
    
    var parameters: Parameters? {
       return nil
    }
    
    var jsonHeader: [String : String] {
       return [NetworkConstants.HTTPHeader.content_type : NetworkConstants.ContentType.json]
    }

    func asURLRequest() throws -> URLRequest {
        let url = try AppConfiguration.apiBaseURL.asURL()
        var urlRequest = URLRequest(url: URL(string:  url.appendingPathComponent(path).absoluteString.removingPercentEncoding ?? "") ?? url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(jsonHeader.first?.value, forHTTPHeaderField: jsonHeader.first?.key ?? "")
        for header in self.extraHeaders {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        debugRequest(urlRequest: urlRequest)
        return urlRequest
    }

    private func debugRequest(urlRequest: URLRequest) {
        print("************************************************************")
        print("======================= URL ================================")
        print(urlRequest.url ?? "")
        print()
        print("======================= Headers ============================")
        print(urlRequest.headers)
        if let body = urlRequest.httpBody {
            print("======================= Body ===========================")
            print(String(describing: body))
        }
        print("************************************************************")
    }
}
