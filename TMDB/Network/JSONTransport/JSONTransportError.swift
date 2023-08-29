//
//  JSONTransportError.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

enum JSONTransportError: Error {
    case unexpectedJSONFormat
}

extension JSONTransportError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unexpectedJSONFormat:
            return "Couldn't decode. Unexpected JSON format is returned!"
        }
    }
}
