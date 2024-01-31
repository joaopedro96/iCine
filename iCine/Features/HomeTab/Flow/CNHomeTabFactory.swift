//
//  CNHomeTabFactory.swift
//  iCine
//
//  Created by João Pedro Mata on 30/01/24.
//

import Foundation

final class CNHomeTabFactory {
    
    // MARK: - PROPERTIES
    
    private let services: CNServicesControllerProtocol
    
    // MARK: - INITIALIZERS
    
    init(services: CNServicesControllerProtocol) {
        self.services = services
    }
    
    // MARK: - PUBLIC METHODS
    
    func makeHomeTabMainViewController() -> CNHomeTabMainViewController {
        let viewcontroller = CNHomeTabMainViewController()
        return viewcontroller
    }
}
