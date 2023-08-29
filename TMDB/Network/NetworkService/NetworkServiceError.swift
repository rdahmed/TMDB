//
//  NetworkServiceError.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

enum NetworkServiceError: Error {
    case noInternetConnection
    case invalidRequest
    case invalidHTTPResponse
    case statusCodeNotAcceptable
    case emptyResponse
}

// MARK: - LocalizedError

extension NetworkServiceError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Oops! Looks like there is no internet connection!"
            
        case .invalidRequest,
             .invalidHTTPResponse,
             .statusCodeNotAcceptable,
             .emptyResponse:
            return "Oops! Something went wrong. Please try again later."
        }
    }
    
}
