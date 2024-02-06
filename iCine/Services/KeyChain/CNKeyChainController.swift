//
//  CNKeyChainController.swift
//  iCine
//
//  Created by João Pedro Mata on 31/01/24.
//

import Foundation

final class CNKeyChainController: CNKeyChainControllerProtocol {
    
    // MARK: - PUBLIC METHODS
    
    func set(keyChain: CNKeyChainProtocol, with value: String) {
        let query = getQuery(for: keyChain, and: value)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch true {
        case status == errSecDuplicateItem:
            update(keyChain: keyChain, with: value)
            return
        
        case status == errSecSuccess:
            showKeyChainLog(for: keyChain.serviceID, operation: "Save Data", status: "Success", data: value)
            return
            
        default:
            showKeyChainLog(for: keyChain.serviceID, operation: "Save Data", status: "Error", data: value)
        }
    }
    
    func get(keyChain: CNKeyChainProtocol) -> String? {
        let query = getReturnDataQuery(for: keyChain)
        
        var encryptedResult: AnyObject?
        let _ = SecItemCopyMatching(query as CFDictionary, &encryptedResult)
        
        guard let encryptedData = encryptedResult as? Data else {
            showKeyChainLog(for: keyChain.serviceID, operation: "Get Data", status: "Error", data: nil)
            return nil
        }
        
        let decriptedData = String(decoding: encryptedData, as: UTF8.self)
        showKeyChainLog(for: keyChain.serviceID, operation: "Get Data", status: "Success", data: decriptedData)
        return decriptedData
    }
    
    func delete(keyChain: CNKeyChainProtocol) {
        let query = getQuery(for: keyChain)
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == noErr {
            showKeyChainLog(for: keyChain.serviceID, operation: "Delete Data", status: "Success", data: nil)
        } else {
            showKeyChainLog(for: keyChain.serviceID, operation: "Delete Data", status: "Error", data: nil)
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func update(keyChain: CNKeyChainProtocol, with value: String) {
        guard let oldValue = get(keyChain: keyChain),
              value != oldValue else {
            showKeyChainLog(for: keyChain.serviceID, operation: "Update Data", status: "Canceled (value duplicated or null)", data: value)
            return
        }
        
        let oldQuery = getQuery(for: keyChain, and: value)
        let newQuery = oldQuery.filter { $0.key != kSecValueData as String }
        let newAttributes = oldQuery.filter { $0.key == kSecValueData as String }
        
        let status = SecItemUpdate(newQuery as CFDictionary, newAttributes as CFDictionary)
        
        switch true {
        case status == errSecSuccess:
            showKeyChainLog(for: keyChain.serviceID, operation: "Update Data", status: "Success", data: value)
            return
            
        default:
            showKeyChainLog(for: keyChain.serviceID, operation: "Update Data", status: "Error", data: value)
        }
    }
    
    private func getQuery(for keyChain: CNKeyChainProtocol,
                          and value: String? = nil) -> [String: AnyObject] {
        var query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyChain.accountID as AnyObject,
            kSecAttrService as String: keyChain.serviceID as AnyObject,
        ]
        
        if let value {
            let encryptedData = value.data(using: .utf8)
            query.updateValue(encryptedData as AnyObject, forKey: kSecValueData as String)
        }

        return query
    }
    
    private func getReturnDataQuery(for keyChain: CNKeyChainProtocol) -> [String: AnyObject] {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyChain.accountID as AnyObject,
            kSecAttrService as String: keyChain.serviceID as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        return query
    }
    
    private func deleteAll() {
        let keys = [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity
        ]
        
        keys.forEach {
            let status = SecItemDelete([
                kSecClass: $0,
                kSecAttrSynchronizable: kSecAttrSynchronizableAny
            ] as CFDictionary)
            
            if status != errSecSuccess && status != errSecItemNotFound {
                print("Error while removing class \($0)")
            }
            
        }
    }
    
}
