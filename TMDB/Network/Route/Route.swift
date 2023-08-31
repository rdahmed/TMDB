//
//  Route.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

enum Route {
    case getNowPlaying
    case getPopular
    case getTopRated
    case getUpcoming
    case search
    case getSimilar(id: String)
    case getDetails(id: String)
    case getReviews(id: String)
    case getCredits(id: String)
    case addRating(id: String)
    case deleteRating(id: String)
}
