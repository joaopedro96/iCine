//
//  CNLoginFooterSectionView.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNLoginFooterSectionViewDelegate: AnyObject {
    func didTapContinueButton()
}

final class CNLoginFooterSectionView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNLoginFooterSectionViewDelegate?
    private var bottomConstraint: NSLayoutConstraint?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var continueButton: CNButton = {
        let setupComponent = CNButton()
        setupComponent.isEnabled = false
        setupComponent.setTitle("Continue", for: .normal)
        setupComponent.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateBottomConstraint(with height: CGFloat) {
        bottomConstraint?.constant = -height
    }
    
    func shouldEnableButton(_ state: Bool) {
        continueButton.isEnabled = state
    }
    
    func shouldShowLoading(_ state: Bool) {
        continueButton.isLoading = state
    }
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapContinueButton() {
        delegate?.didTapContinueButton()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(continueButton)
    }
    
    private func setupConstraints() {
        continueButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        bottomConstraint = continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        bottomConstraint?.isActive = true
    }
}
