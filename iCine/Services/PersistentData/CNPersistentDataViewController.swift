//
//  CNPersistentDataViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 12/10/23.
//

import Foundation

extension CNNetworkController {
    
    // MARK: - PUBLIC METHODS
    
    func setUserDefault(key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getUserDefault(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
