//
//  CNAccountTabFactory.swift
//  iCine
//
//  Created by João Pedro Mata on 30/01/24.
//

import Foundation

final class CNAccountTabFactory {
    
    // MARK: - PROPERTIES
    
    private let services: CNServicesControllerProtocol
    
    // MARK: - INITIALIZERS
    
    init(services: CNServicesControllerProtocol) {
        self.services = services
    }
    
    // MARK: - PUBLIC METHODS
    
    func makeAccountTabMainViewController() -> CNAccountTabMainViewController {
        let viewcontroller = CNAccountTabMainViewController()
        return viewcontroller
    }
}

