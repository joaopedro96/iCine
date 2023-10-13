//
//  CNServicesController.swift
//  iCine
//
//  Created by João Pedro Mata on 13/10/23.
//

import Foundation

final class CNServicesController: CNServicesControllerProtocol {
    
    // MARK: - PROPERTIES
    
    let network: CNNetworkControllerProtocol
    let userDefaults: CNUserDefaultsControllerProtocol
    
    // MARK: - INITIALIZERS
    
    init(network: CNNetworkControllerProtocol = CNNetworkController(),
         userDefaults: CNUserDefaultsControllerProtocol = CNUserDefaultsController()) {
        self.network = network
        self.userDefaults = userDefaults
    }
}
