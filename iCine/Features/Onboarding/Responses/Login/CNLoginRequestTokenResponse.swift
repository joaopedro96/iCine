//
//  CNLoginRequestTokenResponse.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation

struct CNLoginRequestTokenResponse: Codable {
    let success: Bool
    let expireTime: String
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expireTime = "expires_at"
        case requestToken = "request_token"
    }
}
