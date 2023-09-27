//
//  EncodableExtensions.swift
//  iCine
//
//  Created by João Pedro Mata on 26/09/23.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: []),
              let dictionary = json as? [String: Any] else { return nil }
        return dictionary
    }
}
