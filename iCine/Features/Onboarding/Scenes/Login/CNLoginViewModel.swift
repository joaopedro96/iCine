//
//  CNLoginViewModel.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNLoginViewModelDelegate: AnyObject {
    func updateState(with viewState: CNLoginViewState)
}

final class CNLoginViewModel {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNLoginViewModelDelegate?
    private var viewState: CNLoginViewState = .isEmpty {
        didSet {
            delegate?.updateState(with: viewState)
        }
    }
    
    // MARK: - PUBLIC METHODS
    
    func start() {
        getRequestToken()
    }
    
    func openSafari(for url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - FETCH METHODS
    
    private func getRequestToken() {
        viewState = .hasData
    }
}
