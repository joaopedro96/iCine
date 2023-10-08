//
//  PresentedSheetViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 07/10/23.
//  Source: https://github.com/lrssv/BottomSheet

import UIKit

class PresentedSheetViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let sheet: UIView
    private let showIndicatorView: Bool
    
    // MARK: - INITIALIZERS
    
    init(sheet: UIView, showIndicator: Bool = true) {
        self.sheet = sheet
        self.showIndicatorView = showIndicator
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var containerIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 2
        return view
    }()

    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }

    private func buildViewHierarchy() {
        view.addSubview(containerView)
        containerView.addArrangedSubview(containerIndicatorView)
        containerIndicatorView.addSubview(indicatorView)
        containerView.addArrangedSubview(sheet)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerIndicatorView.heightAnchor.constraint(equalToConstant: 4),

            indicatorView.heightAnchor.constraint(equalToConstant: 4),
            indicatorView.widthAnchor.constraint(equalToConstant: 40),
            indicatorView.centerYAnchor.constraint(equalTo: containerIndicatorView.centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: containerIndicatorView.centerXAnchor)
        ])
    }

    private func setupAditionalConfiguration() {
        modalPresentationStyle = .custom
        view.backgroundColor = .bgDisable
        containerIndicatorView.isHidden = !showIndicatorView
    }
}
