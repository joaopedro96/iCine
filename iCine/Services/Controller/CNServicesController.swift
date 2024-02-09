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
    let keyChain: CNKeyChainControllerProtocol

    // MARK: - INITIALIZERS

    init(network: CNNetworkControllerProtocol = CNNetworkController(),
         userDefaults: CNUserDefaultsControllerProtocol = CNUserDefaultsController(),
         keyChain: CNKeyChainControllerProtocol = CNKeyChainController()) {
        self.network = network
        self.userDefaults = userDefaults
        self.keyChain = keyChain
    }
}
