//
//  CNTabBarSignaturesEnum.swift
//  iCine
//
//  Created by João Pedro Mata on 30/01/24.
//

import UIKit

enum CNTabBarSignatures {
    case home
    case search
    case favorites
    case account

    var tabIcon: UIImage {
        switch self {
        case .home:
            return .houseIcon
        case .search:
            return .searchIcon
        case .favorites:
            return .playerIcon
        case .account:
            return .userIcon
        }
    }
}
