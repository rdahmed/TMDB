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
    let posterURL: URL?
    let backdropURL: URL?
    let averageVote: Double?
    
    init(dto: MovieDetailsDTO) {
        self.id = dto.id
        self.title = dto.title
        self.releaseDate = dto.releaseDate.formatted("YYYY-MM-dd")
        self.genres = dto.genres?.map(\.name)
        self.duration = "\(Int(dto.duration / 60))h \(dto.duration % 60)m"
        self.overview = dto.overview
        if let posterPath = dto.posterPath {
            self.posterURL = URL(string: HTTPConfig.imageBaseURL + posterPath)
        } else {
            self.posterURL = nil
        }
        if let backdropPath = dto.backdropPath {
            self.backdropURL = URL(string: HTTPConfig.imageBaseURL + backdropPath)
        } else {
            self.backdropURL = nil
        }
        self.averageVote = dto.averageVote
    }
}
