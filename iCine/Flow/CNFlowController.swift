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
    private var tabBarNavControllers: [UINavigationController] = []
    
    // MARK: - INITIALIZERS
    
    init() {
        services = CNServicesController()
        factory = CNFactory(services: services)
        setupRootNavigation()
        customizeNavigationStyle()
    }
    
    // MARK: - PUBLIC METHODS
    
    func setupTabBar() {
        rootNavigation?.viewControllers.removeAll()
        let tabBar = assembleTabBar()
        let navigation = UINavigationController(rootViewController: tabBar)
        navigation.navigationBar.isHidden = true
        rootNavigation?.pushViewController(tabBar, animated: false)
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
    
    private func assembleTabBar() -> UITabBarController {
        let tabBar = CNMainTabBarController()
        addHomeTab(to: tabBar)
        addSearchTab(to: tabBar)
        addFavoritesTab(to: tabBar)
        addAccountTab(to: tabBar)
        
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        return tabBar
    }
}
