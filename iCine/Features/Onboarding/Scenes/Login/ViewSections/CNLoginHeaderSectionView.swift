//
//  CNLoginHeaderSectionView.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

final class CNLoginHeaderSectionView: UIView {
    
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
    
    private lazy var appIcon: UIImageView = {
        let setupComponent = UIImageView()
        setupComponent.contentMode = .scaleAspectFill
        setupComponent.image = .appIcon
        return setupComponent
    }()
    
    private lazy var userTextField: CNTextField = {
        let setupComponent = CNTextField()
        setupComponent.placeholderText = "Enter your TMDB email"
        return setupComponent
    }()
    
    private lazy var passwordTextField: CNTextField = {
        let setupComponent = CNTextField()
        setupComponent.placeholderText = "Enter your TMDB password"
        setupComponent.isSecureTextEntry = true
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func closeKeyboard() {
        userTextField.closeKeyboard()
        passwordTextField.closeKeyboard()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(appIcon, stackView)
        stackView.addArrangedSubviews(userTextField, passwordTextField)
    }
    
    private func setupConstraints() {
        appIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(135)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(appIcon.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
