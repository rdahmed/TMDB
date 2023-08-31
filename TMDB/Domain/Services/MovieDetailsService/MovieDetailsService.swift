//
//  MovieDetailsService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

class MovieDetailsService: MovieDetailsServiceProtocol {
    private init() {}
    static let `default` = MovieDetailsService()
    
    private let jsonTranspost = JSONTransport()
}

extension MovieDetailsService {
    func getDetails(_ id: Int) -> MoviesPublisher<MovieDetailsDTO> {
        self.jsonTranspost.get(route: .getDetails(id: "\(id)"))
    }
}
