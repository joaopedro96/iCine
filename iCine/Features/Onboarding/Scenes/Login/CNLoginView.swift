//
//  CNLoginView.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNLoginViewDelegate: AnyObject { }

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
        return setupComponent
    }()
    
    private lazy var footerSection: CNLoginFooterSectionView = {
        let setupComponent = CNLoginFooterSectionView()
        setupComponent.delegate = self
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateView(with state: CNLoginViewState) {
       
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
    }
}

// MARK: - EXTENSIONS

extension CNLoginView: CNLoginFooterSectionViewDelegate {
    func didTapContinueButton() {
        print("continue button tapped")
    }
}
