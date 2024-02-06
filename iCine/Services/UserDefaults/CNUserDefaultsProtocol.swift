//
//  CNUserDefaultsProtocol.swift
//  iCine
//
//  Created by João Pedro Mata on 13/10/23.
//

import Foundation

protocol CNUserDefaultsProtocol {
    var key: String { get }
}

protocol CNUserDefaultsControllerProtocol {
    func set(userDefaults: CNUserDefaultsProtocol, value: Any)
    func get(userDefaults: CNUserDefaultsProtocol) -> Any?
}
