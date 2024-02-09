//
//  DynamicKeyboardHeightViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import UIKit

class DynamicKeyboardHeightViewController: UIViewController {

    // MARK: - LIFE CYCLE

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - OVERRIDE METHODS

    func updateViewConstraint(with height: CGFloat) { }

    // MARK: - PRIVATE METHODS

    private func updateViewWithKeyboard(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardHeight = keyboardSize.cgRectValue.height
        updateViewConstraint(with: keyboardHeight + 16)
    }

    @objc private func keyboardWillShow(_ notification: NSNotification) {
        updateViewWithKeyboard(notification: notification)
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        updateViewConstraint(with: 32)
    }
}
