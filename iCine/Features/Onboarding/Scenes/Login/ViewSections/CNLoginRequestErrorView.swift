//
//  CNLoginRequestErrorView.swift
//  iCine
//
//  Created by João Pedro Mata on 07/10/23.
//

import UIKit

protocol CNLoginRequestErrorViewDelegate: AnyObject {
    func didTapButton()
}

final class CNLoginRequestErrorView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNLoginRequestErrorViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var alertIcon: UIImageView = {
        let setupComponent = UIImageView()
        setupComponent.contentMode = .scaleAspectFill
        setupComponent.image = .alertIcon.withTintColor(.bgLight)
        return setupComponent
    }()
    
    private lazy var titleLabel: UILabel = {
        let setupComponent = UILabel()
        setupComponent.text = "Something went wrong"
        setupComponent.font = .systemFont(ofSize: 16, weight: .bold)
        setupComponent.textColor = .txtPrimary
        setupComponent.textAlignment = .center
        return setupComponent
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let setupComponent = UILabel()
        setupComponent.text = "An error occurred when trying to sign in. Please check your TMDB credentials and try again."
        setupComponent.font = .systemFont(ofSize: 16, weight: .regular)
        setupComponent.numberOfLines = 0
        setupComponent.textColor = .txtPrimary
        return setupComponent
    }()
        
    private lazy var okButton: CNButton = {
        let setupComponent = CNButton(buttonType: .secondary)
        setupComponent.setTitle("Ok", for: .normal)
        setupComponent.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapButton() {
        delegate?.didTapButton()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(
            alertIcon,
            titleLabel,
            descriptionLabel,
            okButton
        )
    }
    
    private func setupConstraints() {
        alertIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(alertIcon.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
