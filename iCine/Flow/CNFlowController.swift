//
//  CNFlowController.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

final class CNFlowController {
    
    // MARK: - PROPERTIES
    
    var rootNavigation: UINavigationController?
    private let factory = CNFactory()
    
    // MARK: - INITIALIZERS
    
    init() {
        setupRootNavigation()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupRootNavigation() {
        let rootController = factory.makeOnboardingViewController()
        rootController.delegate = self
        rootNavigation = UINavigationController(rootViewController: rootController)
    }
}
