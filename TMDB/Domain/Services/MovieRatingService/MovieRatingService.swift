//
//  MovieRatingService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

class MovieRatingService: MovieRatingServiceProtocol {
    private init() {}
    static let `default` = MovieRatingService()
    
    private let jsonTranspost = JSONTransport()
}

extension MovieRatingService {
    func addRating(_ id: Int, value: Double) -> MoviesPublisher<MovieRatingDTO> {
        self.jsonTranspost.post(
            route: .addRating(id: "\(id)"),
            headers: ["Content-Type": "application/json;charset=utf-8"],
            params: ["value": "\(value)"]
        )
    }
    
    func deleteRating(_ id: Int) -> MoviesPublisher<MovieRatingDTO> {
        self.jsonTranspost.delete(
            route: .deleteRating(id: "\(id)"),
            headers: ["Content-Type": "application/json;charset=utf-8"]
        )
    }
}
