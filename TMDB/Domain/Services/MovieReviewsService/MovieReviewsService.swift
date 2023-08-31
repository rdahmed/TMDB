//
//  MovieReviewsService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

class MovieReviewsService: MovieReviewsServiceProtocol {
    private init() {}
    static let `default` = MovieReviewsService()
    
    private let jsonTranspost = JSONTransport()
}

extension MovieReviewsService {
    func getReviews(_ id: Int) -> MoviesPublisher<MovieReviewsDTO> {
        self.jsonTranspost.get(route: .getReviews(id: "\(id)"))
    }
}
