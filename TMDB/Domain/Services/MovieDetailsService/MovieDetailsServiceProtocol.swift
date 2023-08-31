//
//  MovieDetailsServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MovieDetailsServiceProtocol {
    func getDetails(_ id: Int) -> MoviesPublisher<MovieDetailsDTO>
}
