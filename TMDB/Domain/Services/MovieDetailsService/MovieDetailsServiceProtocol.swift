//
//  MovieDetailsServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MovieDetailsServiceProtocol {
    func getDetails(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieDetails?, Error>) -> Void)
    )
    func getSimilar(
        to id: Int,
        completionHandler: @escaping ((Result<MovieDetails?, Error>) -> Void)
    )
    func getCredits(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieCast?, Error>) -> Void)
    )
    func getReviews(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieReviews?, Error>) -> Void)
    )
    func addRating(
        _ id: Int,
        value: Double,
        completionHandler: @escaping ((Result<Bool, Error>) -> Void)
    )
    func deleteRating(
        _ id: Int,
        completionHandler: @escaping ((Result<Bool, Error>) -> Void)
    )
}
