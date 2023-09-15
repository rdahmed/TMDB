//
//  JSONTransport+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

class JSONTransportMock: JSONTransportProtocol {
    
    var getCalled = false
    var route: Route?
    
    func get<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers
    ) -> MoviesPublisher<T> where T: Decodable {
        self.getCalled = true
        self.route = route
    }
    
    func post<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        params: Params
    ) -> MoviesPublisher<T> where T: Decodable {
        self.getCalled = true
        self.route = route
    }
    
    func delete<T>(
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        params: Params
    ) -> MoviesPublisher<T> where T: Decodable {
        self.getCalled = true
        self.route = route
    }
    
}
