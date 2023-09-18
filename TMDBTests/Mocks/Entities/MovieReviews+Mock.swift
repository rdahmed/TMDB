//
//  MovieReviews+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

extension MovieReviews {
    static var mock: MovieReviews {
        return .init(dto: .mock)
    }
}

extension MovieReviewsDTO {
    static var mock: MovieReviewsDTO {
        return .init(
            page: 1,
            noOfPages: 1,
            noOfReviews: 1,
            reviews: [.mock]
        )
    }
}

extension MovieReviewDTO {
    static var mock: MovieReviewDTO {
        return .init(
            id: "646bbf8ed1857201802df9c0",
            authorName: "holdenc",
            content: "SOOOOO FIRE I LOVEEEE MARIO PLEEASE MAKE ANOTHER I LOVE YOU MARIO <3",
            creatingDate: "2023-05-22T19:16:30.951Z",
            updatingDate: "2023-05-30T14:25:35.737Z",
            rating: 10
        )
    }
}
