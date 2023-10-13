//
//  CNOnboardingHomeFooterSectionView.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingHomeFooterSectionViewDelegate: AnyObject {
    func didTapSignInButton()
    func didTapSignUpButton()
}

final class CNOnboardingHomeFooterSectionView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNOnboardingHomeFooterSectionViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var stackView: UIStackView = {
        let setupComponent = UIStackView()
        setupComponent.axis = .vertical
        setupComponent.spacing = 16
        return setupComponent
    }()
    
    private lazy var signInButton: CNButton = {
        let setupComponent = CNButton()
        setupComponent.setTitle("Sign in", for: .normal)
        setupComponent.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        return setupComponent
    }()
    
    private lazy var signUpButton: CNButton = {
        let setupComponent = CNButton()
        setupComponent.type = .secondary
        setupComponent.setTitle("Sign up", for: .normal)
        setupComponent.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapSignInButton() {
        delegate?.didTapSignInButton()
    }
    
    @objc private func didTapSignUpButton() {
        delegate?.didTapSignUpButton()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(signInButton, signUpButton)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
