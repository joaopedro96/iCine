//
//  CNLoginValidateTokenPayload.swift
//  iCine
//
//  Created by João Pedro Mata on 02/10/23.
//

import Foundation

struct CNLoginValidateTokenPayload: Codable {
    let username: String
    let password: String
    var requestToken: String

    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}
