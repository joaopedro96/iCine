//
//  CNOnboardingViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingViewControllerDelegate: AnyObject {
    func goToLoginScene()
}

final class CNOnboardingViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNOnboardingViewControllerDelegate?
    private let viewModel: CNOnboardingViewModel
    private let contentView: CNOnboardingView
    
    // MARK: - INITIALIZERS
    
    init(viewModel: CNOnboardingViewModel,
         contentView: CNOnboardingView = CNOnboardingView()) {
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
        setupController()
        viewModel.start()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        viewModel.delegate = self
        contentView.delegate = self
        view = contentView
    }
}

// MARK: - EXTENSIONS

extension CNOnboardingViewController: CNOnboardingViewModelDelegate {
    func updateState(with viewState: CNOnboardingViewState) {
        contentView.updateView(with: viewState)
    }
}

extension CNOnboardingViewController: CNOnboardingViewDelegate {
    func didTapSignInButton() {
        delegate?.goToLoginScene()
    }
    
    func didTapSignUpButton() {
        viewModel.openSafari(for: "https://www.themoviedb.org/signup")
    }
}
