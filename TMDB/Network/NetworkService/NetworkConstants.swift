//
//  NetworkConstants.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation
import Combine

// MARK: - Publisher

typealias MoviesPublisher<T> = AnyPublisher<T, Error> where T: Decodable

// MARK: - Network Typealias

typealias HTTPBody = Data?
typealias Params = [String: Any]
typealias Headers = [String: String]
typealias QueryItems = [String: String]
typealias PathVariables = [String: String]
typealias MultipartFormParams = [String: String]

// MARK: - HTTPMethod

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
