//
//  CNFactory.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import Foundation

final class CNFactory {
    
    // MARK: - PROPERTIES
    
    private let services: CNServicesControllerProtocol
    
    // MARK: - INITIALIZERS
    
    init(services: CNServicesControllerProtocol) {
        self.services = services
    }
    
    // MARK: - ONBOARDING
    
    func makeOnboardingHomeViewController() -> CNOnboardingHomeViewController {
        let viewModel = CNOnboardingHomeViewModel()
        let viewController = CNOnboardingHomeViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeOnboardingLoginViewController() -> CNOnboardingLoginViewController {
        let viewModel = CNOnboardingLoginViewModel(services: services)
        let viewcontroller = CNOnboardingLoginViewController(viewModel: viewModel)
        return viewcontroller
    }
    
    // MARK: - HOME TAB
    
    func makeHomeTabMainViewController() -> CNHomeTabMainViewController {
        let viewcontroller = CNHomeTabMainViewController()
        return viewcontroller
    }
    
    // MARK: - SEARCH TAB
    
    func makeSearchTabMainViewController() -> CNSearchTabMainViewController {
        let viewcontroller = CNSearchTabMainViewController()
        return viewcontroller
    }
    
    // MARK: - FAVORITES TAB
    
    func makeFavoritesTabMainViewController() -> CNFavoritesTabMainViewController {
        let viewcontroller = CNFavoritesTabMainViewController()
        return viewcontroller
    }
    
    // MARK: - ACCOUNT TAB
    
    func makeAccountTabMainViewController() -> CNAccountTabMainViewController {
        let viewcontroller = CNAccountTabMainViewController()
        return viewcontroller
    }
}
