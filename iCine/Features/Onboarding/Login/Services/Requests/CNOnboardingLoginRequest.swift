//
//  CNOnboardingLoginRequest.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation
import Alamofire

enum CNOnboardingLoginRequest: CNNetworkRequestProtocol {

    case requestToken
    case validateToken(payload: CNOnboardingLoginValidateTokenPayload)
    case createSession(requestToken: String)
    case accountDetails(sessionID: String)

    var path: String {
        switch self {
        case .requestToken: return "/authentication/token/new"
        case .validateToken: return "/authentication/token/validate_with_login"
        case .createSession: return "/authentication/session/new"
        case .accountDetails: return "/account"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .validateToken, .createSession:
            return .post
        default:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .validateToken(let payload):
            return payload.asDictionary()
        case .createSession(let requestToken):
            return ["request_token": requestToken]
        case .accountDetails(let sessionID):
            return ["session_id": sessionID]
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
