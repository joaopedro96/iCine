//
//  CNUserDefaultsCommonsEnum.swift
//  iCine
//
//  Created by João Pedro Mata on 13/10/23.
//

import Foundation

enum CNUserDefaultsCommonsEnum: CNUserDefaultsProtocol {
    case accountID
    case sessionID
    
    var key: String {
        switch self {
        case .accountID:
            return "accountID"
        case .sessionID:
            return "sessionID"
        }
    }
}
