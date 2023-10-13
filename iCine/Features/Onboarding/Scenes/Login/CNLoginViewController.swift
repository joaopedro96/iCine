//
//  CNLoginViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNLoginViewControllerDelegate: AnyObject { }

final class CNLoginViewController: DynamicKeyboardHeightViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNLoginViewControllerDelegate?
    private let viewModel: CNLoginViewModel
    private let contentView: CNLoginView
    
    // MARK: - INITIALIZERS
    
    init(viewModel: CNLoginViewModel,
         contentView: CNLoginView = CNLoginView()) {
        self.viewModel = viewModel
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupController()
    }
    
    override func updateViewConstraint(with height: CGFloat) {
        contentView.updateFooterConstraint(with: height)
        view.layoutIfNeeded()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        viewModel.delegate = self
        contentView.delegate = self
        view = contentView
    }
    
    private func setupNavBar() {
        let helpButton = UIButton()
        helpButton.setTitle("Help", for: .normal)
        helpButton.setTitleColor(.txtPrimary, for: .normal)
        helpButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        helpButton.layer.borderWidth = 1
        helpButton.layer.cornerRadius = 14
        helpButton.layer.borderColor = UIColor.bgLight.cgColor
        helpButton.addTarget(self, action: #selector(didTapHelpButton), for: .touchUpInside)
        
        helpButton.snp.makeConstraints { make in
            make.width.equalTo(56)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: helpButton)
    }
    
    private func dismissBottomSheet() {
        dismiss(animated: true)
    }
    
    @objc private func didTapHelpButton() {
        let helpView = CNLoginHelpView()
        helpView.delegate = self
        showBottomSheet(with: helpView)
    }
}

// MARK: - EXTENSIONS

extension CNLoginViewController: CNLoginViewModelDelegate {
    func updateState(with viewState: CNLoginViewState) {
        contentView.updateView(with: viewState)
    }
}

extension CNLoginViewController: CNLoginViewDelegate {
    func createUserSession(with credentials: CNLoginUserCredentials) {
        viewModel.createUserSession(with: credentials)
    }
    
    func presentErrorBottomSheet() {
        let errorView = CNLoginRequestErrorView()
        errorView.delegate = self
        showBottomSheet(with: errorView)
    }
}

extension CNLoginViewController: CNLoginRequestErrorViewDelegate {
    func didTapButton() {
        dismissBottomSheet()
    }
}

extension CNLoginViewController: CNLoginHelpViewDelegate {
    func openSafari(with url: URL) {
        viewModel.openSafari(for: url)
    }
    
    func didTapUnderstoodButton() {
        dismissBottomSheet()
    }
}
