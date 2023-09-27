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
    private var network: CNNetworkControllerProtocol
    private var viewState: CNLoginViewState = .isEmpty {
        didSet {
            delegate?.updateState(with: viewState)
        }
    }

    // MARK: - INITIALIZERS
    
    init(network: CNNetworkControllerProtocol = CNNetworkController()) {
        self.network = network
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
        network.execute(request: CNLoginRequest.requestToken,
                        responseType: CNLoginRequestTokenResponse.self) { [weak self] result in
            
            switch result {
                case .success(let response):
                    print(response)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
