//
//  CNNetworkRequestProtocol.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation
import Alamofire

protocol CNNetworkRequestProtocol {
    var baseURL: String { get }
    var url: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
}

extension CNNetworkRequestProtocol {
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }

    var url: String {
        return baseURL + path
    }
}
