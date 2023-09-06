//
//  MoviesServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MoviesServiceProtocol {
    func getNowPlaying(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies, Error>) -> Void)
    )
    func getPopular(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies, Error>) -> Void)
    )
    func getTopRated(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies, Error>) -> Void)
    )
    func getUpcoming(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies, Error>) -> Void)
    )
    func search(
        _ keyword: String,
        page: Int,
        completionHandler: @escaping ((Result<Movies, Error>) -> Void)
    )
}
