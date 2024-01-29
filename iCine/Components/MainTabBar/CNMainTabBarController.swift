//
//  CNMainTabBarController.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

final class CNMainTabBarController: UITabBarController {
    
    // MARK: - PROPERTIES
    
    var navigationControllers: [UINavigationController] = []
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
    }
    
    // MARK: - PUBLIC METHODS
    
    func addTab(tabRootController: UIViewController, tabImage: UIImage) {
        let navController = UINavigationController(rootViewController: tabRootController)
        navController.tabBarItem = makeNewTab(with: tabImage)

        tabRootController.tabBarController?.tabBar.tag = navigationControllers.count
        navigationControllers.append(navController)
        setViewControllers(navigationControllers, animated: true)
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
    
    private func setupTabBarAppearance() {
        let normalStateColor = [NSAttributedString.Key.foregroundColor: UIColor.bgDisable]
        let selectedStateColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //TODO: Testar com background translucido. TitleTextAttributes provavelmente n sao necessarios
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .bgDark
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalStateColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedStateColor
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
