//
//  MovieDetailsDTO.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

struct MovieDetailsDTO: Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let genres: [Genre]?
    let duration: Int
    let overview: String
    let ratingAsAdults: Bool
    let posterPath: String?
    let backdropPath: String?
    let noOfVotes: Int?
    let averageVote: Double?
    let status: String?
    let tagline: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genres
        case duration = "runtime"
        case overview
        case ratingAsAdults = "adult"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case noOfVotes = "vote_count"
        case averageVote = "vote_average"
        case status
        case tagline
        case url = "homepage"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        self.duration = try container.decode(Int.self, forKey: .duration)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.ratingAsAdults = try container.decode(Bool.self, forKey: .ratingAsAdults)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.noOfVotes = try container.decodeIfPresent(Int.self, forKey: .noOfVotes)
        self.averageVote = try container.decodeIfPresent(Double.self, forKey: .averageVote)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
