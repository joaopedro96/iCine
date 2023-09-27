//
//  CNLoginRequest.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation
import Alamofire

enum CNLoginRequest: CNNetworkRequestProtocol {
    
    case requestToken
    
    var path: String {
        switch self {
            case .requestToken: return "/authentication/token/new"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            default:
                return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
            default: return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            default:
                let headers = [
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTgxOTFkNDg2NGU0ZGJkODg4ODBkZWY1MjJjYmY1OCIsInN1YiI6IjY0ZjdkYzJmNWYyYjhkMDEzOWNmZWZjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ap7njLzLQD8ClQQbT0aFEhRFCNM5_rUnHoupAlA2n3E"
                ]
                let httpHeaders = HTTPHeaders(headers)
                return httpHeaders
        }
    }
}
