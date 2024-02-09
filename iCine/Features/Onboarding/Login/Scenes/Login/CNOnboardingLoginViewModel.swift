//
//  CNOnboardingLoginViewModel.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNOnboardingLoginViewModelDelegate: AnyObject {
    func updateState(with viewState: CNOnboardingLoginViewState)
    func goToHomeScene()
}

final class CNOnboardingLoginViewModel {

    // MARK: - PROPERTIES

    weak var delegate: CNOnboardingLoginViewModelDelegate?
    private var services: CNServicesControllerProtocol
    private var viewState: CNOnboardingLoginViewState = .isEmpty {
        didSet {
            delegate?.updateState(with: viewState)
        }
    }

    // MARK: - INITIALIZERS

    init(services: CNServicesControllerProtocol) {
        self.services = services
    }

    // MARK: - PUBLIC METHODS

    func createUserSession(with credentials: CNOnboardingLoginUserCredentials) {
        viewState = .isLoading
        getRequestToken(with: credentials)
    }

    func openSafari(for url: URL) {
        UIApplication.shared.open(url)
    }

    // MARK: - PRIVATE METHODS

    private func makeValidateTokenPayload(with credentials: CNOnboardingLoginUserCredentials, and token: String) {
        let payload = CNOnboardingLoginValidateTokenPayload(
            username: credentials.username,
            password: credentials.password,
            requestToken: token
        )
        postValidateToken(with: payload)
    }

    // TODO: - Delete one persitent data below
    private func setUserData(_ sessionID: String, _ accountID: Int) {
        services.userDefaults.set(userDefaults: CNUserDefaultsCommonsEnum.sessionID, value: sessionID)
        services.userDefaults.set(userDefaults: CNUserDefaultsCommonsEnum.accountID, value: accountID)

        services.keyChain.set(keyChain: CNKeyChainCommonsEnum.sessionID, with: sessionID)
        services.keyChain.set(keyChain: CNKeyChainCommonsEnum.accountID, with: accountID.asString())
    }

    // MARK: - FETCH METHODS

    private func getRequestToken(with credentials: CNOnboardingLoginUserCredentials) {
        services.network.execute(
            request: CNOnboardingLoginRequest.requestToken,
            responseType: CNOnboardingLoginRequestTokenResponse.self
        ) { [weak self] result in

            switch result {
            case .success(let response):
                self?.makeValidateTokenPayload(with: credentials, and: response.requestToken)

            case .failure:
                self?.viewState = .hasError
            }
        }
    }

    private func postValidateToken(with payload: CNOnboardingLoginValidateTokenPayload) {
        services.network.execute(
            request: CNOnboardingLoginRequest.validateToken(payload: payload),
            responseType: CNOnboardingLoginRequestTokenResponse.self
        ) { [weak self] result in

            switch result {
            case .success(let response):
                self?.postCreateSession(with: response.requestToken)

            case .failure:
                self?.viewState = .hasError
            }
        }
    }

    private func postCreateSession(with requestToken: String) {
        services.network.execute(
            request: CNOnboardingLoginRequest.createSession(requestToken: requestToken),
            responseType: CNOnboardingLoginCreateSessionResponse.self
        ) { [weak self] result in

            switch result {
            case .success(let response):
                self?.getAccountDetails(with: response.sessionID)

            case .failure:
                self?.viewState = .hasError
            }
        }
    }

    private func getAccountDetails(with sessionID: String) {
        services.network.execute(
            request: CNOnboardingLoginRequest.accountDetails(sessionID: sessionID),
            responseType: CNOnboardingLoginAccountDetailsResponse.self
        ) { [weak self] result in

            switch result {
            case .success(let response):
                self?.setUserData(sessionID, response.id)
                self?.viewState = .hasData
                self?.delegate?.goToHomeScene()

            case .failure:
                self?.viewState = .hasError
            }
        }
    }
}
