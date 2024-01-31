//
//  CNTabBarProtocols.swift
//  iCine
//
//  Created by João Pedro Mata on 30/01/24.
//

import UIKit

protocol CNTabBarFlowControllerProtocol {
    var rootNavigation: UINavigationController? { get set }
    var tabBarSignature: CNTabBarSignatures { get }
}
