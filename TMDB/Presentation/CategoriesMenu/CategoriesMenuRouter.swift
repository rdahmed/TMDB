//
//  CategoriesMenuRouter.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol CategoriesMenuRouter: AnyObject {
    func showPopularMovies()
    func showNowPlayingMovies()
    func showUpcomingMovies()
    func showTopRatedMovies()
}
