//
//  CNSearchTabFactory.swift
//  iCine
//
//  Created by João Pedro Mata on 30/01/24.
//

import Foundation

final class CNSearchTabFactory {
    
    // MARK: - PROPERTIES
    
    private let services: CNServicesControllerProtocol
    
    // MARK: - INITIALIZERS
    
    init(services: CNServicesControllerProtocol) {
        self.services = services
    }
    
    // MARK: - PUBLIC METHODS
    
    func makeSearchTabMainViewController() -> CNSearchTabMainViewController {
        let viewcontroller = CNSearchTabMainViewController()
        return viewcontroller
    }
}

