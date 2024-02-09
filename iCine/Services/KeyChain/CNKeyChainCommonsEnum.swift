//
//  CNKeyChainCommonsEnum.swift
//  iCine
//
//  Created by João Pedro Mata on 05/02/24.
//

import Foundation

enum CNKeyChainCommonsEnum: CNKeyChainProtocol {
    case accountID
    case sessionID

    var accountID: String {
        switch self {
        case .accountID:
            "tmdb-token"
        case .sessionID:
            "tmdb-token"
        }
    }

    var serviceID: String {
        switch self {
        case .accountID:
            "tmdb-account-token"
        case .sessionID:
            "tmdb-session-token"
        }
    }
}
