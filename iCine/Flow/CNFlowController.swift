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
    let factory = CNFactory()
    
    // MARK: - INITIALIZERS
    
    init() {
        setupRootNavigation()
        customizeNavigationStyle()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupRootNavigation() {
        let rootController = factory.makeOnboardingViewController()
        rootController.delegate = self
        rootNavigation = UINavigationController(rootViewController: rootController)
    }
    
    private func customizeNavigationStyle() {
        rootNavigation?.navigationBar.backIndicatorImage = .leftArrowIcon
        rootNavigation?.navigationBar.backIndicatorTransitionMaskImage = .leftArrowIcon
        rootNavigation?.navigationBar.topItem?.backButtonTitle = ""
    }
}