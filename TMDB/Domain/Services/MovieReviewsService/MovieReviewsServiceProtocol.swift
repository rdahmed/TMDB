//
//  MovieReviewsServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MovieReviewsServiceProtocol {
    func getReviews(_ id: Int) -> MoviesPublisher<MovieReviewsDTO>
}
