//
//  CNServicesControllerProtocol.swift
//  iCine
//
//  Created by João Pedro Mata on 13/10/23.
//

import Foundation

protocol CNServicesControllerProtocol {
    var network: CNNetworkControllerProtocol { get }
    var userDefaults: CNUserDefaultsControllerProtocol { get }
    var keyChain: CNKeyChainControllerProtocol { get }
}
