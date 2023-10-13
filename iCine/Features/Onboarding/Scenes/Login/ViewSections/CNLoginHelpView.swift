//
//  CNLoginHelpView.swift
//  iCine
//
//  Created by João Pedro Mata on 12/10/23.
//

import UIKit

protocol CNLoginHelpViewDelegate: AnyObject {
    func openSafari(with url: URL)
    func didTapUnderstoodButton()
}

final class CNLoginHelpView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNLoginHelpViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var tmdbIcon: UIImageView = {
        let setupComponent = UIImageView()
        setupComponent.contentMode = .scaleAspectFill
        setupComponent.image = .tmdbLogo
        return setupComponent
    }()
    
    private lazy var descriptionLabel: CNHyperlinkTextView = {
        let setupComponent = CNHyperlinkTextView()
        setupComponent.text = "iCine was developed based on the API data provided by The Movie Database (TMDB).\n\nTo access iCine app its necessary to sign in with your TMDB credentials. If you don't have an active account you can sign up on TMDB official website."
        setupComponent.font = .systemFont(ofSize: 16, weight: .regular)
        setupComponent.textColor = .txtPrimary
        setupComponent.setHyperlinks(["TMDB official website.": "https://www.themoviedb.org"])
        setupComponent.hyperlinkDelegate = self
        return setupComponent
    }()
    
    private lazy var warningLabel: UILabel = {
        let setupComponent = UILabel()
        setupComponent.text = "This product uses the TMDB API but is not endorsed or certified by TMDB."
        setupComponent.font = .systemFont(ofSize: 16, weight: .bold)
        setupComponent.textColor = .txtPrimary
        setupComponent.textAlignment = .center
        setupComponent.numberOfLines = 0
        return setupComponent
    }()
        
    private lazy var understoodButton: CNButton = {
        let setupComponent = CNButton(buttonType: .secondary)
        setupComponent.setTitle("Understood", for: .normal)
        setupComponent.addTarget(self, action: #selector(didTapUnderstoodButton), for: .touchUpInside)
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapUnderstoodButton() {
        delegate?.didTapUnderstoodButton()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(
            tmdbIcon,
            descriptionLabel,
            warningLabel,
            understoodButton
        )
    }
    
    private func setupConstraints() {
        tmdbIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(230)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tmdbIcon.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        understoodButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - EXTENSIONS

extension CNLoginHelpView: CNHyperlinkTextViewDelegate {
    func triggerLink(for url: URL, atRange range: NSRange) {
        delegate?.openSafari(with: url)
    }
}
