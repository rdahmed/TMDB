//
//  MovieRatingServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MovieRatingServiceProtocol {
    func addRating(_ id: Int, value: Double) -> MoviesPublisher<MovieRatingDTO>
    func deleteRating(_ id: Int) -> MoviesPublisher<MovieRatingDTO>
}
