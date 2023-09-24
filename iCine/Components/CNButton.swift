//
//  CNButton.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

enum CNButtonType {
    case primary
    case secondary
}

final class CNButton: UIButton {
    
    // MARK: - PROPERTIES
    
    var type: CNButtonType = .primary {
        didSet {
            setupTypeProperties()
        }
    }
    
    // MARK: - INITIALIZERS
    
    init(buttonType: CNButtonType = .primary) {
        type = buttonType
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupButton() {
        setupDefaultProperties()
        setupTypeProperties()
    }
    
    private func setupDefaultProperties() {
        layer.cornerRadius = 8
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    private func setupTypeProperties() {
        switch type {
            case .primary:
                setupPrimaryButton()
                
            case .secondary:
                setupSecondaryButton()
        }
    }
    
    private func setupPrimaryButton() {
        setTitleColor(.txtSecondary, for: .normal)
        backgroundColor = .bgLight
    }
    
    private func setupSecondaryButton() {
        setTitleColor(.txtPrimary, for: .normal)
        backgroundColor = . clear
        layer.borderColor = UIColor.bgLight.cgColor
        layer.borderWidth = 1
    }
    
}
