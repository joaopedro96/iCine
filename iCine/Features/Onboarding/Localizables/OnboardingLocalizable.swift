//
//  OnboardingLocalizable.swift
//  iCine
//
//  Created by João Pedro Mata on 06/02/24.
//

import Foundation

extension String {
    func onboardingLocalized() -> String {
        return NSLocalizedString(self,
                                 tableName: "OnboardingLocalizable",
                                 value: self,
                                 comment: self)
    }
}
