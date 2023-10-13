//
//  CNFlowController+Onboarding.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import Foundation

extension CNFlowController: CNOnboardingHomeViewControllerDelegate {
    func goToLoginScene() {
        let viewController = factory.makeOnboardingLoginViewController()
        viewController.delegate = self
        rootNavigation?.pushViewController(viewController, animated: true)
    }
}

extension CNFlowController: CNOnboardingLoginViewControllerDelegate { }
