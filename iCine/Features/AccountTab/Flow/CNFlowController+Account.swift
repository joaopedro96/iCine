//
//  CNFlowController+Account.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

extension CNFlowController {
    func addAccountTab(to tabBar: CNMainTabBarController) {
        let accountVC = factory.makeAccountTabMainViewController()
        tabBar.addTab(tabRootController: accountVC, tabImage: .userIcon)
    }
}
