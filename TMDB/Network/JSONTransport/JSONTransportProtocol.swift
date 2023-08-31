//
//  JSONTransportProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation
import Combine

protocol JSONTransportProtocol {
    
    // MARK: - GET
    
    func get<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers
    ) -> MoviesPublisher<T> where T: Decodable
    
    // MARK: - POST
    
    func post<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        params: Params
    ) -> MoviesPublisher<T> where T: Decodable
    
    // MARK: - DELETE
    
    func delete<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        params: Params
    ) -> MoviesPublisher<T> where T: Decodable
    
}

extension JSONTransportProtocol {
    
    func get<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers
    ) -> MoviesPublisher<T> where T: Decodable {
        self.get(
            route: route,
            queryItems: queryItems,
            headers: headers
        )
    }
    
    func post<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        params: Params
    ) -> MoviesPublisher<T> where T: Decodable {
        self.post(
            route: route,
            queryItems: queryItems,
            headers: headers,
            params: params
        )
    }
    
    func delete<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        params: Params
    ) -> MoviesPublisher<T> where T: Decodable {
        self.delete(
            route: route,
            queryItems: queryItems,
            headers: headers,
            params: params
        )
    }
    
}
