//
//  MoviesList+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

extension Movies {
    static var mock: Movies {
        return .init(dto: .mock)
    }
}

extension MoviesDTO {
    static var mock: MoviesDTO {
        return .init(
            page: 1,
            noOfPages: 1,
            noOfMovies: 1,
            movies: [.mock]
        )
    }
}

extension MovieDTO {
    static var mock: MovieDTO {
        return .init(
            id: 502356,
            title: "The Super Mario Bros",
            releaseDate: "2023-04-05",
            posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
            averageVote: 7.5
        )
    }
}

extension Movie: Equatable {
    public static func == (lhs: TMDB.Movie, rhs: TMDB.Movie) -> Bool {
        lhs.id == rhs.id
    }
}

extension Movies: Equatable {
    public static func == (lhs: TMDB.Movies, rhs: TMDB.Movies) -> Bool {
        lhs.movies
            .filter { movie in rhs.movies.contains(where: { $0 == movie }) }
            .count == lhs.movies.count
    }
}
