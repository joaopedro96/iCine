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
    let factory: CNFactory
    private let services: CNServicesControllerProtocol
    
    // MARK: - INITIALIZERS
    
    init() {
        services = CNServicesController()
        factory = CNFactory(services: services)
        setupRootNavigation()
        customizeNavigationStyle()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupRootNavigation() {
        let rootController = factory.makeOnboardingHomeViewController()
        rootController.delegate = self
        rootNavigation = UINavigationController(rootViewController: rootController)
    }
    
    private func customizeNavigationStyle() {
        rootNavigation?.navigationBar.backIndicatorImage = .leftArrowIcon
        rootNavigation?.navigationBar.backIndicatorTransitionMaskImage = .leftArrowIcon
        rootNavigation?.navigationBar.topItem?.backButtonTitle = ""
    }
}
