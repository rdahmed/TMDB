//
//  JSONTransport.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

class JSONTransport: JSONTransportProtocol {
    
    // MARK: - GET
    
    func get<T>(
        route: Route,
        queryItems: QueryItems = [:],
        headers: Headers = [:]
    ) -> MoviesPublisher<T> where T: Decodable {
        self.perform(
            route: route,
            method: .get,
            queryItems: queryItems,
            headers: headers
        )
    }
    
    // MARK: - POST
    
    func post<T>(
        route: Route,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        params: Params = [:]
    ) -> MoviesPublisher<T> where T: Decodable {
        let body = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        return self.perform(
            route: route,
            method: .post,
            queryItems: queryItems,
            headers: headers,
            body: body
        )
    }
    
    // MARK: - DELETE
    
    func delete<T>(
        route: Route,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        params: Params = [:]
    ) -> MoviesPublisher<T> where T: Decodable {
        let body = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        return self.perform(
            route: route,
            method: .delete,
            queryItems: queryItems,
            headers: headers,
            body: body
        )
    }
    
}

private extension JSONTransport {
    
    func perform<T>(
        route: Route,
        method: HTTPMethod,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        body: HTTPBody = nil
    ) -> MoviesPublisher<T> where T: Decodable {
        NetworkService.shared.request(
            route: route,
            method: method,
            queryItems: queryItems,
            headers: headers,
            body: body
        )
    }
    
}
