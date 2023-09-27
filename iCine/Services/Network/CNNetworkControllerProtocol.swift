//
//  CNNetworkControllerProtocol.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation
import Alamofire

protocol CNNetworkControllerProtocol {
    func execute<T: Decodable>(request: CNNetworkRequestProtocol,
                               responseType: T.Type,
                               completion: @escaping (Result<T, Error>) -> Void)
    func logRequest(with response: AFDataResponse<Data?>, data: Data?, error: Error?)
    func logParseError(for error: Error)
}

extension CNNetworkControllerProtocol {
    
    func logRequest(with response: AFDataResponse<Data?>, data: Data? = nil, error: Error? = nil) {
        guard let requestResponse = response.response,
              let url = requestResponse.url,
              let request = response.request,
              let method = request.method else { return }
        
        print("\n--------------------------------------------------------------")
        print("- URL: \(url)\n")
        print("- Method: \(method.rawValue)\n")
        print("- Status: \(requestResponse.statusCode)\n")
        
        if let body = request.httpBody {
            print("- Parameters: \(body.prettyPrintedJSONString)\n")
        }
        
        if let data = data {
            print("- JSON: \(data.prettyPrintedJSONString)")
        } else if let error = error {
            print("- Description: \(error.localizedDescription)")
        }
    }
    
    func logParseError(for error: Error) {
        print("\n-------------------------PARSE ERROR--------------------------")
        print(error)
    }
}
