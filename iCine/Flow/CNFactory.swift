//
//  CNFactory.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import Foundation

final class CNFactory {
    
    // MARK: - ONBOARDING
    
    func makeOnboardingViewController() -> CNOnboardingViewController {
        let viewModel = CNOnboardingViewModel()
        let viewController = CNOnboardingViewController(viewModel: viewModel)
        return viewController
    }
    
    
    
}
