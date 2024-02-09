//
//  CNOnboardingHomeViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingHomeViewControllerDelegate: AnyObject {
    func goToLoginScene()
}

final class CNOnboardingHomeViewController: UIViewController {

    // MARK: - PROPERTIES

    weak var delegate: CNOnboardingHomeViewControllerDelegate?
    private let viewModel: CNOnboardingHomeViewModel
    private let contentView: CNOnboardingHomeView

    // MARK: - INITIALIZERS

    init(viewModel: CNOnboardingHomeViewModel,
         contentView: CNOnboardingHomeView = CNOnboardingHomeView()) {
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

extension CNOnboardingHomeViewController: CNOnboardingHomeViewModelDelegate {
    func updateState(with viewState: CNOnboardingHomeViewState) {
        contentView.updateView(with: viewState)
    }
}

extension CNOnboardingHomeViewController: CNOnboardingHomeViewDelegate {
    func didTapSignInButton() {
        delegate?.goToLoginScene()
    }

    func didTapSignUpButton() {
        viewModel.openSafari(for: "https://www.themoviedb.org/signup")
    }
}
