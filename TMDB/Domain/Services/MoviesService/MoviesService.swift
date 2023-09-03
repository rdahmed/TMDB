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
    func getNowPlaying(_ page: Int) -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getNowPlaying, queryItems: ["page" : "\(page)"])
    }
    
    func getPopular(_ page: Int) -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getPopular, queryItems: ["page" : "\(page)"])
    }
    
    func getTopRated(_ page: Int) -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getTopRated, queryItems: ["page" : "\(page)"])
    }
    
    func getUpcoming(_ page: Int) -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .getUpcoming, queryItems: ["page" : "\(page)"])
    }
    
    func search(_ keyword: String, page: Int) -> MoviesPublisher<MoviesDTO> {
        self.jsonTranspost.get(route: .search, queryItems: ["query": keyword, "page" : "\(page)"])
    }
}
