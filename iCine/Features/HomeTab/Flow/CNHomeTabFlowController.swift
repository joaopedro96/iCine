//
//  CNHomeTabFlowController.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

protocol CNHomeTabFlowControllerDelegate: AnyObject {
    func goToFavoritesTab()
}

final class CNHomeTabFlowController: CNTabBarFlowControllerProtocol {
    
    // MARK: - PROPERTIES
    
    weak var flowDelegate: CNHomeTabFlowControllerDelegate?
    var rootNavigation: UINavigationController?
    let tabBarSignature: CNTabBarSignatures = .home
    let factory: CNHomeTabFactory
    
    // MARK: - INITIALIZERS
    
    init(services: CNServicesControllerProtocol) {
        factory = CNHomeTabFactory(services: services)
        start()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func start() {
        setupRootNavigation()
    }
    
    private func setupRootNavigation() {
        let rootController = factory.makeHomeTabMainViewController()
        rootController.flowDelegate = self
        rootNavigation = UINavigationController(rootViewController: rootController)
    }
}

// MARK: - EXTENSIONS

extension CNHomeTabFlowController: CNHomeTabMainViewControllerDelegate {
    func goToFavoritesTab() {
        flowDelegate?.goToFavoritesTab()
    }
}
