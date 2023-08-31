//
//  NetworkServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    
    func request<T>(
        route: Route,
        method: HTTPMethod,
        queryItems: QueryItems,
        headers: Headers,
        body: HTTPBody
    ) -> MoviesPublisher<T>
    
}
