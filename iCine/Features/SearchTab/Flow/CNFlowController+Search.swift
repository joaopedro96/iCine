//
//  CNFlowController+Search.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

extension CNFlowController {
    func addSearchTab(to tabBar: CNMainTabBarController) {
        let searchVC = factory.makeSearchTabMainViewController()
        tabBar.addTab(tabRootController: searchVC, tabImage: .searchIcon)
    }
}
