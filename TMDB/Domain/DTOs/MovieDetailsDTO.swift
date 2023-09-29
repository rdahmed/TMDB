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
    let posterPath: String?
    let backdropPath: String?
    let averageVote: Double?
    
    init(
        id: Int,
        title: String,
        releaseDate: String,
        genres: [Genre]?,
        duration: Int,
        overview: String,
        posterPath: String?,
        backdropPath: String?,
        averageVote: Double?
    ) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.genres = genres
        self.duration = duration
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.averageVote = averageVote
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genres
        case duration = "runtime"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case averageVote = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        self.duration = try container.decode(Int.self, forKey: .duration)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.averageVote = try container.decodeIfPresent(Double.self, forKey: .averageVote)
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
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
