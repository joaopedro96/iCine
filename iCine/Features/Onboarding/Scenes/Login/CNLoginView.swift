//
//  CNLoginView.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNLoginViewDelegate: AnyObject {
    func createUserSession(with credentials: CNLoginUserCredentials)
    func presentErrorBottomSheet()
}

final class CNLoginView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNLoginViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var headerSection: CNLoginHeaderSectionView = {
        let setupComponent = CNLoginHeaderSectionView()
        setupComponent.delegate = self
        return setupComponent
    }()
    
    private lazy var footerSection: CNLoginFooterSectionView = {
        let setupComponent = CNLoginFooterSectionView()
        setupComponent.delegate = self
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateView(with state: CNLoginViewState) {
        switch state {
            case .hasData:
                footerSection.shouldShowLoading(false)
            case .isLoading:
                footerSection.shouldShowLoading(true)
            case .hasError:
                footerSection.shouldShowLoading(false)
                delegate?.presentErrorBottomSheet()
            default: return
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
        let credentials = CNLoginUserCredentials(
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

extension CNLoginView: CNLoginHeaderSectionViewDelegate {
    func shouldEnableButton(_ state: Bool) {
        footerSection.shouldEnableButton(state)
    }
}

extension CNLoginView: CNLoginFooterSectionViewDelegate {
    func didTapContinueButton() {
        headerSection.closeKeyboard()
        makeUserCredentialsObject()
    }
}
