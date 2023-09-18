//
//  MovieDetails+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

extension MovieDetails {
    static var mock: MovieDetails {
        return .init(dto: .mock)
    }
}

extension MovieDetailsDTO {
    static var mock: MovieDetailsDTO {
        return .init(
            id: 502356,
            title: "The Super Mario Bros",
            releaseDate: "2023-04-05",
            genres: [
                .init(id: 12, name: "Adventure"),
                .init(id: 14, name: "Fantasy"),
                .init(id: 16, name: "Animation"),
                .init(id: 35, name: "Comedy"),
                .init(id: 10751, name: "Family")
            ],
            duration: 93,
            overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
            posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
            backdropPath: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
            averageVote: 7.774
        )
    }
}
