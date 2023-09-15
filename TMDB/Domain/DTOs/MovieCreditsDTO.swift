//
//  MovieCreditsDTO.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

struct MovieCreditsDTO: Decodable {
    let id: Int
    let cast: [MovieCastMemberDTO]
    
    init(id: Int, cast: [MovieCastMemberDTO]) {
        self.id = id
        self.cast = cast
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.cast = try container.decode([MovieCastMemberDTO].self, forKey: .cast)
    }
}

struct MovieCastMemberDTO: Decodable {
    let name: String
    let character: String
    let profilePath: String?
    
    init(
        name: String,
        character: String,
        profilePath: String?
    ) {
        self.name = name
        self.character = character
        self.profilePath = profilePath
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case character
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.character = try container.decode(String.self, forKey: .character)
        self.profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
    }
}
