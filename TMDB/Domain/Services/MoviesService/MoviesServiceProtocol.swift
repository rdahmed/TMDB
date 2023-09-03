//
//  MoviesServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MoviesServiceProtocol {
    func getNowPlaying(_ page: Int) -> MoviesPublisher<MoviesDTO>
    func getPopular(_ page: Int) -> MoviesPublisher<MoviesDTO>
    func getTopRated(_ page: Int) -> MoviesPublisher<MoviesDTO>
    func getUpcoming(_ page: Int) -> MoviesPublisher<MoviesDTO>
    func search(_ keyword: String, page: Int) -> MoviesPublisher<MoviesDTO>
}
