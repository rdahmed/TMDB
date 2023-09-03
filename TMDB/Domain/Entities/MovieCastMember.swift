//
//  MovieCastMember.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

struct MovieCastMember {
    let name: String
    let character: String
    let profileURL: String?
    
    init(dto: MovieCastMemberDTO) {
        self.name = dto.name
        self.character = dto.character
        if let profilePath = dto.profilePath {
            self.profileURL = HTTPConfig.imageBaseURL + profilePath
        } else {
            self.profileURL = nil
        }
    }
}
