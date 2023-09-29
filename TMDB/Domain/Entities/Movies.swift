//
//  Movies.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

struct Movies {
    let noOfPages: Int
    let movies: [Movie]
    
    init(dto: MoviesDTO) {
        self.noOfPages = dto.noOfPages
        self.movies = dto.movies.map { Movie(dto: $0) }
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterURL: URL?
    let averageVote: Double?
    
    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.releaseDate = dto.releaseDate.formatted("YYYY-MM-dd")
        if let posterPath = dto.posterPath {
            self.posterURL = URL(string: HTTPConfig.imageBaseURL + posterPath)
        } else {
            self.posterURL = nil
        }   
        self.averageVote = dto.averageVote
    }
}
