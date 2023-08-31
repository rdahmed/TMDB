//
//  Movie.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

typealias Movies = [Movie]

struct Movie {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
    let averageVote: Double?
    
    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.releaseDate = dto.releaseDate.formatted("YYYY-MM-dd")
        self.posterPath = dto.posterPath
        self.averageVote = dto.averageVote
    }
}
