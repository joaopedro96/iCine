//
//  CNLoginCreateSessionResponse.swift
//  iCine
//
//  Created by João Pedro Mata on 02/10/23.
//

import Foundation

struct CNLoginCreateSessionResponse: Codable {
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
    }
}
