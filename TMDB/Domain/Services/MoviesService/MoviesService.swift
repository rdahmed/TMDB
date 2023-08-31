//
//  MoviesService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

class MoviesService: MoviesServiceProtocol {
    private init() {}
    static let `default` = MoviesService()
    
    private let jsonTranspost = JSONTransport()
}

extension MoviesService {
    func getNowPlaying() -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getNowPlaying)
    }
    
    func getPopular() -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getPopular)
    }
    
    func getTopRated() -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getTopRated)
    }
    
    func getUpcoming() -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getUpcoming)
    }
    
    func getSimilar(to id: Int) -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getSimilar(id: "\(id)"))
    }
    
    func search(_ keyword: String) -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .search, queryItems: ["query": keyword])
    }
}
