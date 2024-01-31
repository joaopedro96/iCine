//
//  CNOnboardingFlowController.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingFlowControllerDelegate: AnyObject {
    func didAuthenticateLogin()
}

final class CNOnboardingFlowController {
    
    // MARK: - PROPERTIES
    
    weak var flowDelegate: CNOnboardingFlowControllerDelegate?
    var rootNavigation: UINavigationController?
    let factory: CNOnboardingFactory
        
    // MARK: - INITIALIZERS
    
    init(rootNavigation: UINavigationController?, services: CNServicesControllerProtocol) {
        self.rootNavigation = rootNavigation
        factory = CNOnboardingFactory(services: services)
    }
    
    // MARK: - PUBLIC METHODS
    
    func start() {
        setupRootNavigation()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupRootNavigation() {
        let rootController = factory.makeOnboardingHomeViewController()
        rootController.delegate = self
        rootNavigation?.setViewControllers([rootController], animated: false)
    }
}

// MARK: - EXTENSIONS

extension CNOnboardingFlowController: CNOnboardingHomeViewControllerDelegate {
    func goToLoginScene() {
        let viewController = factory.makeOnboardingLoginViewController()
        viewController.delegate = self
        rootNavigation?.pushViewController(viewController, animated: true)
    }
}

extension CNOnboardingFlowController: CNOnboardingLoginViewControllerDelegate {
    func goToHomeScene() {
        flowDelegate?.didAuthenticateLogin()
    }
}
