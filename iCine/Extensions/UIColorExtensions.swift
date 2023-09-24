//
//  UIColorExtensions.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

extension UIColor {
    
    // MARK: - BACKGROUND
    
    class var bgDark: UIColor {
        return initialize(with: "bgDark")
    }
    
    class var bgLight: UIColor {
        return initialize(with: "bgLight")
    }
    
    // MARK: - TEXT
    
    class var txtPrimary: UIColor {
        return initialize(with: "txtPrimary")
    }
    
    class var txtSecondary: UIColor {
        return initialize(with: "txtSecondary")
    }
    
    // MARK: - INITIALIZERS
    
    fileprivate class func initialize(with name: String) -> UIColor {
        return UIColor(named: name, in: Bundle.main, compatibleWith: nil) ?? .red
    }
}
