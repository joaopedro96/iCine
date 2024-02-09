//
//  CNFavoritesTabFlowController.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

protocol CNFavoritesTabFlowControllerDelegate: AnyObject { }

final class CNFavoritesTabFlowController: CNTabBarFlowControllerProtocol {

    // MARK: - PROPERTIES

    weak var flowDelegate: CNFavoritesTabFlowControllerDelegate?
    var rootNavigation: UINavigationController?
    let tabBarSignature: CNTabBarSignatures = .favorites
    let factory: CNFavoritesTabFactory

    // MARK: - INITIALIZERS

    init(services: CNServicesControllerProtocol) {
        factory = CNFavoritesTabFactory(services: services)
        start()
    }

    // MARK: - PRIVATE METHODS

    private func start() {
        setupRootNavigation()
    }

    private func setupRootNavigation() {
        let rootController = factory.makeFavoritesTabMainViewController()
        rootNavigation = UINavigationController(rootViewController: rootController)
    }
}
