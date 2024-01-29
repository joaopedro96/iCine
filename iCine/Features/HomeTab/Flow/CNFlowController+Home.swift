//
//  CNFlowController+Home.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

extension CNFlowController {
    func addHomeTab(to tabBar: CNMainTabBarController) {
        let homeVC = factory.makeHomeTabMainViewController()
        tabBar.addTab(tabRootController: homeVC, tabImage: .houseIcon)
    }
}
