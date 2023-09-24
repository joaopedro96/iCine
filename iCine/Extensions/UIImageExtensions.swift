//
//  UIImageExtensions.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

extension UIImage {
    
    // MARK: - COMMONS
    
    class var appLogo: UIImage {
        return initialize(with: "iCineLogo")
    }
    
    class var appIcon: UIImage {
        return initialize(with: "iCineIcon")
    }
    
    // MARK: - ONBOARDING
    
    class var onboardingPoster: UIImage {
        return initialize(with: "OnboardingPosterImage")
    }
    
    // MARK: - INITIALIZERS
    
    fileprivate class func initialize(with name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.main, compatibleWith: nil) ?? UIImage()
    }
}
