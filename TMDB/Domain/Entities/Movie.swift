//
//  Movie.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let releaseDate: String
    let posterData: Data?
    let averageVote: Double?
    
    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.releaseDate = dto.releaseDate.formatted("YYYY-MM-dd")
        if let posterPath = dto.posterPath,
           let posterURL = URL(string: HTTPConfig.imageBaseURL + posterPath),
           let data = try? Data(contentsOf: posterURL)
        {
            self.posterData = data
        } else {
            self.posterData = nil
        }   
        self.averageVote = dto.averageVote
    }
}
