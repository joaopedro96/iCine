//
//  CNOnboardingHomeView.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingHomeViewDelegate: AnyObject {
    func didTapSignInButton()
    func didTapSignUpButton()
}

final class CNOnboardingHomeView: UIView {

    // MARK: - PROPERTIES

    weak var delegate: CNOnboardingHomeViewDelegate?

    // MARK: - UI

    private lazy var backgroundSection: CNOnboardingHomeBackgroundSectionView = {
        let setupComponent = CNOnboardingHomeBackgroundSectionView()
        return setupComponent
    }()

    private lazy var stackView: UIStackView = {
        let setupComponent = UIStackView()
        setupComponent.axis = .vertical
        setupComponent.spacing = 72
        return setupComponent
    }()

    private lazy var bodySection: CNOnboardingHomeBodySectionView = {
        let setupComponent = CNOnboardingHomeBodySectionView()
        return setupComponent
    }()

    private lazy var footerSection: CNOnboardingHomeFooterSectionView = {
        let setupComponent = CNOnboardingHomeFooterSectionView()
        setupComponent.delegate = self
        return setupComponent
    }()

    // MARK: - PUBLIC METHODS

    func updateView(with state: CNOnboardingHomeViewState) {
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

extension CNOnboardingHomeView: CNOnboardingHomeFooterSectionViewDelegate {
    func didTapSignInButton() {
        delegate?.didTapSignInButton()
    }

    func didTapSignUpButton() {
        delegate?.didTapSignUpButton()
    }
}
