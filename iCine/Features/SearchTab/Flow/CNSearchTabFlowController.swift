//
//  CNSearchTabFlowController.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

protocol CNSearchTabFlowControllerDelegate: AnyObject { }

final class CNSearchTabFlowController: CNTabBarFlowControllerProtocol {

    // MARK: - PROPERTIES

    weak var flowDelegate: CNSearchTabFlowControllerDelegate?
    var rootNavigation: UINavigationController?
    let tabBarSignature: CNTabBarSignatures = .search
    let factory: CNSearchTabFactory

    // MARK: - INITIALIZERS

    init(services: CNServicesControllerProtocol) {
        factory = CNSearchTabFactory(services: services)
        start()
    }

    // MARK: - PRIVATE METHODS

    private func start() {
        setupRootNavigation()
    }

    private func setupRootNavigation() {
        let rootController = factory.makeSearchTabMainViewController()
        rootNavigation = UINavigationController(rootViewController: rootController)
    }
}
