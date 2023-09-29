//
//  MovieCategory.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

enum MovieCategory: CaseIterable {
    case popular
    case nowPlaying
    case upcoming
    case topRated
    
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        }
    }
}
