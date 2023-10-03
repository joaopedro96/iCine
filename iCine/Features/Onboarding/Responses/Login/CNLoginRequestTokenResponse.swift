//
//  CNLoginRequestTokenResponse.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation

struct CNLoginRequestTokenResponse: Codable {
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}
