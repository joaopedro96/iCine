//
//  CNOnboardingViewModel.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit

protocol CNOnboardingViewModelDelegate: AnyObject {
    func updateState(with viewState: CNOnboardingViewState)
}

final class CNOnboardingViewModel {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNOnboardingViewModelDelegate?
    private var viewState: CNOnboardingViewState = .isEmpty {
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
