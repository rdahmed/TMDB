//
//  MoviesList+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

extension Movies {
    static var mock: Self {
        return .init(dto: .mock)
    }
}

extension MoviesDTO {
    static var mock: Self {
        return .init(
            page: 1,
            noOfPages: 1,
            noOfMovies: 1,
            movies: [.mock]
        )
    }
}

extension MovieDTO {
    static var mock: Self {
        return .init(
            id: 502356,
            title: "The Super Mario Bros",
            releaseDate: "2023-04-05",
            posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
            averageVote: 7.5
        )
    }
}
