//
//  UIViewControllerExtensions.swift
//  iCine
//
//  Created by João Pedro Mata on 07/10/23.
//

import UIKit

extension UIViewController {
    func showBottomSheet(with sheet: UIView, showIndicatorView: Bool = true) {
        let bottomSheet = BottomSheetViewController(
            sheet: sheet,
            presenting: self,
            showIndicator: showIndicatorView
        )
        present(bottomSheet.viewController, animated: true, completion: nil)
    }
}
