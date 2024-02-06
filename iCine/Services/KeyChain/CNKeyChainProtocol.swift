//
//  CNKeyChainProtocol.swift
//  iCine
//
//  Created by João Pedro Mata on 05/02/24.
//

import Foundation

protocol CNKeyChainProtocol {
    var accountID: String { get }
    var serviceID: String { get }
}

protocol CNKeyChainControllerProtocol {
    func set(keyChain: CNKeyChainProtocol, with value: String)
    func get(keyChain: CNKeyChainProtocol) -> String?
    func delete(keyChain: CNKeyChainProtocol)
    func showKeyChainLog(for serviceID: String, operation: String, status: String, data: String?)
}

extension CNKeyChainControllerProtocol {
    func showKeyChainLog(for serviceID: String, operation: String, status: String, data: String?) {
        print("- - - - - KEYCHAIN LOG - - - - -")
        print("- Service ID: \(serviceID)")
        print("- Operation: \(operation)")
        print("- Status: \(status)")
        print("- Data: \(data ?? "null")\n")
    }
}
