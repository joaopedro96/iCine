//
//  CNMainTabBarController.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

final class CNMainTabBarController: UITabBarController {

    // MARK: - PROPERTIES

    private var tabFlowControllers: [CNTabBarFlowControllerProtocol] = []

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
    }

    // MARK: - PUBLIC METHODS

    func addTab(_ tabFlowController: CNTabBarFlowControllerProtocol?) {
        guard let tabFlowController = tabFlowController,
              let tabNavigation = tabFlowController.rootNavigation else { return }

        tabNavigation.tabBarItem = makeNewTab(with: tabFlowController.tabBarSignature.tabIcon)
        tabFlowControllers.append(tabFlowController)
        setTabFlowController()
    }

    func changeTab(to tabSignature: CNTabBarSignatures) {
        if let index = tabFlowControllers.firstIndex(where: { $0.tabBarSignature == .favorites }) {
            selectedIndex = index
        }
    }

    // MARK: - PRIVATE METHODS

    private func makeNewTab(with image: UIImage) -> UITabBarItem {
        let tabIBarItem = UITabBarItem(
            title: nil,
            image: image.withTintColor(.bgDisable),
            selectedImage: image.withTintColor(.white)
        )
        tabIBarItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -12, right: 0)
        return tabIBarItem
    }

    private func setTabFlowController() {
        var navControllers: [UINavigationController] = []
        tabFlowControllers.forEach {
            guard let rootController = $0.rootNavigation else { return }
            navControllers.append(rootController)
        }
        setViewControllers(navControllers, animated: true)
    }

    private func setupTabBarAppearance() {
        let normalStateColor = [NSAttributedString.Key.foregroundColor: UIColor.bgDisable]
        let selectedStateColor = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // TODO: Testar com background translucido. TitleTextAttributes provavelmente n sao necessarios

        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .bgDark
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalStateColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedStateColor
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
