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
    
    func start() { }
    
    func createUserSession(with credentials: CNLoginUserCredentials) {
        getRequestToken(with: credentials)
    }
    
    func openSafari(for url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func makeValidateTokenPayload(with credentials: CNLoginUserCredentials, and token: String) {
        let payload = CNLoginValidateTokenPayload(
            username: credentials.username,
            password: credentials.password,
            requestToken: token
        )
        postValidateToken(with: payload)
    }
    
    // MARK: - FETCH METHODS
    
    private func getRequestToken(with credentials: CNLoginUserCredentials) {
        network.execute(request: CNLoginRequest.requestToken,
                        responseType: CNLoginRequestTokenResponse.self) { [weak self] result in
            
            switch result {
                case .success(let response):
                    self?.makeValidateTokenPayload(with: credentials, and: response.requestToken)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func postValidateToken(with payload: CNLoginValidateTokenPayload) {
        network.execute(request: CNLoginRequest.validateToken(payload: payload),
                        responseType: CNLoginRequestTokenResponse.self) { [weak self] result in
            
            switch result {
                case .success(let response):
                    self?.postCreateSession(with: response.requestToken)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func postCreateSession(with requestToken: String) {
        network.execute(request: CNLoginRequest.createSession(requestToken: requestToken),
                        responseType: CNLoginCreateSessionResponse.self) { [weak self] result in
            
            switch result {
                case .success(let response):
                    self?.getAccountDetails(with: response.sessionID)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func getAccountDetails(with sessionID: String) {
        network.execute(request: CNLoginRequest.accountDetails(sessionID: sessionID),
                        responseType: CNLoginAccountDetailsResponse.self) { [weak self] result in
            
            switch result {
                case .success(let response):
                    print(self?.viewState as Any)
                    print(response.id)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
