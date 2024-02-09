//
//  CNCustomColors.swift
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

    class var bgDarkGrey: UIColor {
        return initialize(with: "bgDarkGrey")
    }

    class var bgDisable: UIColor {
        return initialize(with: "bgDisable")
    }

    class var bgLight: UIColor {
        return initialize(with: "bgLight")
    }

    class var bgLightGrey: UIColor {
        return initialize(with: "bgLightGrey")
    }

    // MARK: - BORDER

    class var borderLight: UIColor {
        return initialize(with: "borderLight")
    }

    class var borderLightGrey: UIColor {
        return initialize(with: "borderLightGrey")
    }

    // MARK: - TEXT

    class var txtPrimary: UIColor {
        return initialize(with: "txtPrimary")
    }

    class var txtSecondary: UIColor {
        return initialize(with: "txtSecondary")
    }

    class var txtTertiary: UIColor {
        return initialize(with: "txtTertiary")
    }

    // MARK: - INITIALIZERS

    fileprivate class func initialize(with name: String) -> UIColor {
        return UIColor(named: name, in: Bundle.main, compatibleWith: nil) ?? .red
    }
}
