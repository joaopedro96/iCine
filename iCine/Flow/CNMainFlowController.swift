//
//  CNMainFlowController.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

final class CNMainFlowController {
    
    // MARK: - PROPERTIES
    
    var mainRootNavigation: UINavigationController?
    private let services: CNServicesControllerProtocol = CNServicesController()
    private var onboardingFlow: CNOnboardingFlowController?
    private var tabBarController: CNMainTabBarController?
    private var homeTabFlow: CNHomeTabFlowController?
    private var searchTabFlow: CNSearchTabFlowController?
    private var favoritesTabFlow: CNFavoritesTabFlowController?
    private var accountTabFlow: CNAccountTabFlowController?
    
    // MARK: - PUBLIC METHODS
    
    func start() {
        assembleOnboardingFlowController()
        startOnboardingFlow()
        customizeNavigationStyle()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func assembleOnboardingFlowController() {
        onboardingFlow = CNOnboardingFlowController(rootNavigation: mainRootNavigation, services: services)
        onboardingFlow?.flowDelegate = self
    }
    
    private func assembleTabBarFlowControllers() {
        homeTabFlow = CNHomeTabFlowController(services: services)
        homeTabFlow?.flowDelegate = self
        
        searchTabFlow = CNSearchTabFlowController(services: services)
        searchTabFlow?.flowDelegate = self
        
        favoritesTabFlow = CNFavoritesTabFlowController(services: services)
        favoritesTabFlow?.flowDelegate = self
        
        accountTabFlow = CNAccountTabFlowController(services: services)
        accountTabFlow?.flowDelegate = self
    }
    
    private func startOnboardingFlow() {
        onboardingFlow?.start()
    }
    
    private func customizeNavigationStyle() {
        mainRootNavigation?.navigationBar.backIndicatorImage = .leftArrowIcon
        mainRootNavigation?.navigationBar.backIndicatorTransitionMaskImage = .leftArrowIcon
        mainRootNavigation?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    private func setupTabBar() {
        assembleTabBarFlowControllers()
        tabBarController = assembleTabBar()
        guard let tabBar = tabBarController else { return }
        let navigation = UINavigationController(rootViewController: tabBar)
        navigation.navigationBar.isHidden = true
        mainRootNavigation?.setViewControllers([tabBar], animated: true)
    }
    
    private func assembleTabBar() -> CNMainTabBarController {
        let tabBar = CNMainTabBarController()
        tabBar.addTab(homeTabFlow)
        tabBar.addTab(searchTabFlow)
        tabBar.addTab(favoritesTabFlow)
        tabBar.addTab(accountTabFlow)
        return tabBar
    }
}

// MARK: - EXTENSIONS

extension CNMainFlowController: CNOnboardingFlowControllerDelegate {
    func didAuthenticateLogin() {
        setupTabBar()
    }
}

extension CNMainFlowController: CNHomeTabFlowControllerDelegate {
    func goToFavoritesTab() {
        tabBarController?.changeTab(to: .favorites)
    }
}

extension CNMainFlowController: CNSearchTabFlowControllerDelegate { }

extension CNMainFlowController: CNFavoritesTabFlowControllerDelegate { }

extension CNMainFlowController: CNAccountTabFlowControllerDelegate { }
