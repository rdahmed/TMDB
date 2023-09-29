//
//  MovieCast.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

typealias MovieCast = [MovieCastMember]

struct MovieCastMember {
    let name: String
    let character: String
    let profileURL: URL?
    
    init(dto: MovieCastMemberDTO) {
        self.name = dto.name
        self.character = dto.character
        if let profilePath = dto.profilePath {
            self.profileURL = URL(string: HTTPConfig.imageBaseURL + profilePath)
        } else {
            self.profileURL = nil
        }
    }
}
