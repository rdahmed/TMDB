//
//  MovieCast+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

extension MovieCast {
    static var mock: MovieCast {
        return [.init(dto: .mock1), .init(dto: .mock2)]
    }
}

extension MovieCastMember: Equatable {
    public static func == (lhs: MovieCastMember, rhs: MovieCastMember) -> Bool {
        lhs.name == rhs.name
    }
}

extension MovieCastMemberDTO {
    static var mock1: MovieCastMemberDTO {
        .init(
            name: "Chris Pratt",
            character: "Mario (voice)",
            profilePath: "/9vHfySKm8fxaCOACAybNt69neTO.jpg"
        )
    }
    
    static var mock2: Self {
        .init(
            name: "Anya Taylor-Joy",
            character: "Princess Peach (voice)",
            profilePath: "/jxAbDJWvz4p1hoFpJYG5vY2dQmq.jpg"
        )
    }
}
