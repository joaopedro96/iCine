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
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
