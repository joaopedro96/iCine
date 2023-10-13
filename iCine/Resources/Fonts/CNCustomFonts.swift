//
//  CNCustomFonts.swift
//  iCine
//
//  Created by João Pedro Mata on 13/10/23.
//

import UIKit

extension UIFont {
    
    // MARK: - INTER FONT
    
    static func inter(ofSize size: CGFloat, weight: CNFontWeight) -> UIFont {
        let fontName = "Inter-\(weight.rawValue)"
        let interFont = UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
        return interFont
    }
}
