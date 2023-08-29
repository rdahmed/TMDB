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
        case .getNowPlaying: return "/now_playing"
        case .getPopular: return "/popular"
        case .getTopRated: return "/top_rated"
        case .getUpcoming: return "/upcoming"
        case .getDetails(let id): return "/\(id)"
        case .getReviews(let id): return "/\(id)/reviews"
        case .addRating(let id): return "/\(id)/rating"
        case .deleteRating(let id): return "/\(id)/rating"
        }
    }
}
