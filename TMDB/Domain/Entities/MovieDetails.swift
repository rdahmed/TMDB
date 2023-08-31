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
    let genres: [Genre]?
    let duration: Int
    let overview: String
    let ratingAsAdults: Bool
    let posterURL: String?
    let backdropURL: String?
    let noOfVotes: Int?
    let averageVote: Double?
    let status: String?
    let tagline: String?
    let url: String?
    
    init(dto: MovieDetailsDTO) {
        self.id = dto.id
        self.title = dto.title
        self.releaseDate = dto.releaseDate.formatted("YYYY-MM-dd")
        self.genres = dto.genres
        self.duration = dto.duration
        self.overview = dto.overview
        self.ratingAsAdults = dto.ratingAsAdults
        if let posterPath = dto.posterPath {
            self.posterURL = HTTPConfig.imageBaseURL + posterPath
        } else {
            self.posterURL = nil
        }
        if let backdropPath = dto.backdropPath {
            self.backdropURL = HTTPConfig.imageBaseURL + backdropPath
        } else {
            self.backdropURL = nil
        }
        self.noOfVotes = dto.noOfVotes
        self.averageVote = dto.averageVote
        self.status = dto.status
        self.tagline = dto.tagline
        self.url = dto.url
    }
}
