//
//  CNOnboardingHomeViewModel.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingHomeViewModelDelegate: AnyObject {
    func updateState(with viewState: CNOnboardingHomeViewState)
}

final class CNOnboardingHomeViewModel {

    // MARK: - PROPERTIES

    weak var delegate: CNOnboardingHomeViewModelDelegate?
    private var viewState: CNOnboardingHomeViewState = .isEmpty {
        didSet {
            delegate?.updateState(with: viewState)
        }
    }

    // MARK: - PUBLIC METHODS

    func start() {
        viewState = .hasData
    }

    func openSafari(for url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
