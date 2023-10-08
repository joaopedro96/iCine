//
//  UIImageExtensions.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

extension UIImage {
    
    // MARK: - COMMONS
    
    class var alertIcon: UIImage {
        return initializeSystemIcon(with: "exclamationmark.circle")
    }
    
    class var appLogo: UIImage {
        return initialize(with: "iCineLogo")
    }
    
    class var appIcon: UIImage {
        return initialize(with: "iCineIcon")
    }
    
    class var eyeIcon: UIImage {
        return initializeSystemIcon(with: "eye.fill")
    }
    
    class var leftArrowIcon: UIImage {
        return initialize(with: "leftArrow")
    }
    
    class var slashedEyeIcon: UIImage {
        return initializeSystemIcon(with: "eye.slash.fill")
    }
    
    // MARK: - ONBOARDING
    
    class var onboardingPoster: UIImage {
        return initialize(with: "OnboardingPosterImage")
    }
    
    // MARK: - INITIALIZERS
    
    fileprivate class func initialize(with name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.main, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    }
    
    fileprivate class func initializeSystemIcon(with systemName: String) -> UIImage {
        return UIImage(systemName: systemName)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    }
}
