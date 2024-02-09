//
//  CNOnboardingLoginView.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNOnboardingLoginViewDelegate: AnyObject {
    func createUserSession(with credentials: CNOnboardingLoginUserCredentials)
    func presentErrorBottomSheet()
}

final class CNOnboardingLoginView: UIView {

    // MARK: - PROPERTIES

    weak var delegate: CNOnboardingLoginViewDelegate?

    // MARK: - INITIALIZERS

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var headerSection: CNOnboardingLoginHeaderSectionView = {
        let setupComponent = CNOnboardingLoginHeaderSectionView()
        setupComponent.delegate = self
        return setupComponent
    }()

    private lazy var footerSection: CNOnboardingLoginFooterSectionView = {
        let setupComponent = CNOnboardingLoginFooterSectionView()
        setupComponent.delegate = self
        return setupComponent
    }()

    // MARK: - PUBLIC METHODS

    func updateView(with state: CNOnboardingLoginViewState) {
        switch state {
        case .hasData:
            footerSection.shouldShowLoading(false)
        case .isLoading:
            footerSection.shouldShowLoading(true)
        case .hasError:
            footerSection.shouldShowLoading(false)
            delegate?.presentErrorBottomSheet()
        default:
            return
        }
    }

    func updateFooterConstraint(with height: CGFloat) {
        footerSection.updateBottomConstraint(with: height)
    }

    // MARK: - PRIVATE METHODS

    @objc private func didTapView() {
        headerSection.closeKeyboard()
    }

    private func makeUserCredentialsObject() {
        let credentials = CNOnboardingLoginUserCredentials(
            username: headerSection.getUserName(),
            password: headerSection.getUserPassword()
        )
        delegate?.createUserSession(with: credentials)
    }

    // MARK: - SETUP VIEW

    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
        customizeView()
    }

    private func buildViewHierarchy() {
        addSubviews(headerSection, footerSection)
    }

    private func setupConstraints() {
        headerSection.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }

        footerSection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func customizeView() {
        backgroundColor = .bgDark
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
}

// MARK: - EXTENSIONS

extension CNOnboardingLoginView: CNOnboardingLoginHeaderSectionViewDelegate {
    func shouldEnableButton(_ state: Bool) {
        footerSection.shouldEnableButton(state)
    }
}

extension CNOnboardingLoginView: CNOnboardingLoginFooterSectionViewDelegate {
    func didTapContinueButton() {
        headerSection.closeKeyboard()
        makeUserCredentialsObject()
    }
}
