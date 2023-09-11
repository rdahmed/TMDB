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
    let profileData: Data?
    
    init(dto: MovieCastMemberDTO) {
        self.name = dto.name
        self.character = dto.character
        if let profilePath = dto.profilePath,
           let profileURL = URL(string: HTTPConfig.imageBaseURL + profilePath),
           let data = try? Data(contentsOf: profileURL)
        {
            self.profileData = data
        } else {
            self.profileData = nil
        }
    }
}
