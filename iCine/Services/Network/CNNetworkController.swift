//
//  CNNetworkController.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation
import Alamofire

final class CNNetworkController: CNNetworkControllerProtocol {

    // MARK: - PUBLIC METHODS

    func execute<T: Decodable>(request: CNNetworkRequestProtocol,
                               responseType: T.Type,
                               completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(request.url,
                   method: request.method,
                   parameters: request.parameters,
                   headers: request.headers).validate().response { [weak self] response in

            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                self?.logRequest(with: response, data: data)
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    self?.logParseError(for: error)
                    completion(.failure(error))
                }

            case .failure(let error):
                self?.logRequest(with: response, error: error)
                completion(.failure(error))
            }
        }
    }
}
