//
//  MovieCreditsServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MovieCreditsServiceProtocol {
    func getCredits(_ id: Int) -> MoviesPublisher<MovieCreditsDTO>
}
