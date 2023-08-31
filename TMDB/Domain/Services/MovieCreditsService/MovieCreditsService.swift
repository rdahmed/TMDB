//
//  MovieCreditsService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

class MovieCreditsService: MovieCreditsServiceProtocol {
    private init() {}
    static let `default` = MovieCreditsService()
    
    private let jsonTranspost = JSONTransport()
}

extension MovieCreditsService {
    func getCredits(_ id: Int) -> MoviesPublisher<MovieCreditsDTO> {
        self.jsonTranspost.get(route: .getCredits(id: "\(id)"))
    }
}
