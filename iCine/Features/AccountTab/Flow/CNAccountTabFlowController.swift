//
//  CNAccountTabFlowController.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

protocol CNAccountTabFlowControllerDelegate: AnyObject { }

final class CNAccountTabFlowController: CNTabBarFlowControllerProtocol {

    // MARK: - PROPERTIES

    weak var flowDelegate: CNAccountTabFlowControllerDelegate?
    var rootNavigation: UINavigationController?
    let tabBarSignature: CNTabBarSignatures = .account
    let factory: CNAccountTabFactory

    // MARK: - INITIALIZERS

    init(services: CNServicesControllerProtocol) {
        factory = CNAccountTabFactory(services: services)
        start()
    }

    // MARK: - PRIVATE METHODS

    private func start() {
        setupRootNavigation()
    }

    private func setupRootNavigation() {
        let rootController = factory.makeAccountTabMainViewController()
        rootNavigation = UINavigationController(rootViewController: rootController)
    }
}
