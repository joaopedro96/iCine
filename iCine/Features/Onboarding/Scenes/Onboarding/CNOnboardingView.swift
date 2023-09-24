//
//  CNOnboardingView.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingViewDelegate: AnyObject {
    func didTapSignInButton()
    func didTapSignUpButton()
}

final class CNOnboardingView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNOnboardingViewDelegate?
    
    // MARK: - UI
    
    private lazy var backgroundSection: CNOnboardingBackgroundSectionView = {
        let setupComponent = CNOnboardingBackgroundSectionView()
        return setupComponent
    }()
    
    private lazy var stackView: UIStackView = {
        let setupComponent = UIStackView()
        setupComponent.axis = .vertical
        setupComponent.spacing = 72
        return setupComponent
    }()
    
    private lazy var bodySection: CNOnboardingBodySectionView = {
        let setupComponent = CNOnboardingBodySectionView()
        return setupComponent
    }()
    
    private lazy var footerSection: CNOnboardingFooterSectionView = {
        let setupComponent = CNOnboardingFooterSectionView()
        setupComponent.delegate = self
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateView(with state: CNOnboardingViewState) {
        setupView()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func populateStackView() {
        stackView.addArrangedSubviews(bodySection, footerSection)
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
        customizeView()
    }
    
    private func buildViewHierarchy() {
        addSubviews(backgroundSection, stackView)
        populateStackView()
    }
    
    private func setupConstraints() {
        backgroundSection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func customizeView() {
        backgroundColor = .bgDark
    }
}

// MARK: - EXTENSIONS

extension CNOnboardingView: CNOnboardingFooterSectionViewDelegate {
    func didTapSignInButton() {
        delegate?.didTapSignInButton()
    }
    
    func didTapSignUpButton() {
        delegate?.didTapSignUpButton()
    }
}
