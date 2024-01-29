//
//  CNFlowController+Favorites.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

extension CNFlowController {
    func addFavoritesTab(to tabBar: CNMainTabBarController) {
        let favoritesVC = factory.makeFavoritesTabMainViewController()
        tabBar.addTab(tabRootController: favoritesVC, tabImage: .playerIcon)
    }
}
