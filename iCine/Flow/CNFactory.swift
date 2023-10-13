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
}
