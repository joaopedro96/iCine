//
//  CNOnboardingFactory.swift
//  iCine
//
//  Created by João Pedro Mata on 30/01/24.
//

import Foundation

final class CNOnboardingFactory {

    // MARK: - PROPERTIES

    private let services: CNServicesControllerProtocol

    // MARK: - INITIALIZERS

    init(services: CNServicesControllerProtocol) {
        self.services = services
    }

    // MARK: - PUBLIC METHODS

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
