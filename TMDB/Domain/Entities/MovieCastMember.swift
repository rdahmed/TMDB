//
//  MovieCastMember.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

typealias MovieCast = [MovieCastMember]

struct MovieCastMember {
    let name: String
    let character: String
    let profilePath: String
    
    init(dto: MovieCastMemberDTO) {
        self.name = dto.name
        self.character = dto.character
        self.profilePath = dto.profilePath
    }
}
