//
//  Route+Path.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

extension Route {
    var path: String {
        switch self {
        case .getNowPlaying: return "/movie/now_playing"
        case .getPopular: return "/movie/popular"
        case .getTopRated: return "/movie/top_rated"
        case .getUpcoming: return "/movie/upcoming"
        case .search: return "search/movie"
        case .getSimilar(let id): return "/movie/\(id)/similar"
        case .getDetails(let id): return "/movie/\(id)"
        case .getReviews(let id): return "/movie/\(id)/reviews"
        case .getCredits(let id): return "/movie/\(id)/credits"
        case .addRating(let id): return "/movie/\(id)/rating"
        case .deleteRating(let id): return "/movie/\(id)/rating"
        }
    }
}
