//
//  CNOnboardingHomeBodySectionView.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

final class CNOnboardingHomeBodySectionView: UIView {
    
    // MARK: - CONSTANTS
    
    private let welcomeTitle = "home_welcome_title".onboardingLocalized()
    private let welcomeDescription = "home_welcome_description".onboardingLocalized()
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var appIcon: UIImageView = {
        let setupComponent = UIImageView()
        setupComponent.contentMode = .scaleAspectFill
        setupComponent.image = .appIcon
        return setupComponent
    }()
    
    private lazy var titleLabel: UILabel = {
        let setupComponent = UILabel()
        setupComponent.text = welcomeTitle
        setupComponent.font = .inter(ofSize: 36, weight: .regular)
        setupComponent.textColor = .txtPrimary
        setupComponent.textAlignment = .center
        setupComponent.numberOfLines = 0
        return setupComponent
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let setupComponent = UILabel()
        setupComponent.text = welcomeDescription
        setupComponent.font = .inter(ofSize: 16, weight: .regular)
        setupComponent.textColor = .txtPrimary
        setupComponent.textAlignment = .center
        setupComponent.numberOfLines = 0
        return setupComponent
    }()
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(
            appIcon,
            titleLabel,
            descriptionLabel
        )
    }
    
    private func setupConstraints() {
        appIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(170)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(appIcon.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
