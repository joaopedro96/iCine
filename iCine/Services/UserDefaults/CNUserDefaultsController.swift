//
//  CNUserDefaultsController.swift
//  iCine
//
//  Created by João Pedro Mata on 12/10/23.
//

import Foundation

final class CNUserDefaultsController: CNUserDefaultsControllerProtocol {

    // MARK: - PUBLIC METHODS

    func set(userDefaults: CNUserDefaultsProtocol, value: Any) {
        UserDefaults.standard.set(value, forKey: userDefaults.key)
    }

    func get(userDefaults: CNUserDefaultsProtocol) -> Any? {
        return UserDefaults.standard.object(forKey: userDefaults.key)
    }
}
