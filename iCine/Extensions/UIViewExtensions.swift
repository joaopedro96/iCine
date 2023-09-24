//
//  UIViewExtensions.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: UIView...) {
        views.forEach { itemView in
            addSubview(itemView)
        }
    }
}
