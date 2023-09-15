//
//  MovieDetails.swift
//  TMDB
//
//  Created by Radwa Ahmed on 30/08/2023.
//

import Foundation

struct MovieDetails {
    let id: Int
    let title: String
    let releaseDate: String
    let genres: [String]?
    let duration: String
    let overview: String
    let posterData: Data?
    let backdropData: Data?
    let averageVote: Double?
    
    init(dto: MovieDetailsDTO) {
        self.id = dto.id
        self.title = dto.title
        self.releaseDate = dto.releaseDate.formatted("YYYY-MM-dd")
        self.genres = dto.genres?.map(\.name)
        self.duration = "\(Int(dto.duration / 60))h \(dto.duration % 60)m"
        self.overview = dto.overview
        if let posterPath = dto.posterPath,
           let posterURL = URL(string: HTTPConfig.imageBaseURL + posterPath),
           let data = try? Data(contentsOf: posterURL)
        {
            self.posterData = data
        } else {
            self.posterData = nil
        }
        if let backdropPath = dto.backdropPath,
           let backdropURL = URL(string: HTTPConfig.imageBaseURL + backdropPath),
           let data = try? Data(contentsOf: backdropURL)
        {
            self.backdropData = data
        } else {
            self.backdropData = nil
        }
        self.averageVote = dto.averageVote
    }
}
