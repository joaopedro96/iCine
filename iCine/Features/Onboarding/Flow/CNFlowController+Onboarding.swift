//
//  CNFlowController+Onboarding.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import Foundation

extension CNFlowController: CNOnboardingViewControllerDelegate {
    func goToLoginScene() {
        let viewController = factory.makeLoginViewController()
        viewController.delegate = self
        rootNavigation?.pushViewController(viewController, animated: true)
    }
}

extension CNFlowController: CNLoginViewControllerDelegate { }
