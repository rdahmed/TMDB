//
//  CategoriesMenuViewModel.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

class CategoriesMenuViewModel {
    
    // MARK: - Dependencies
    
    private let router: CategoriesMenuRouter
    
    // MARK: - Initializers
    
    init(router: CategoriesMenuRouter) {
        self.router = router
    }
    
    deinit {
        print(#function, #file)
    }
    
}

// MARK: - ViewModelInput

extension CategoriesMenuViewModel: CategoriesMenuViewModelInputProtocol {
    
    func didTapOnCategory(_ category: MovieCategory) {
        switch category {
        case .popular:
            self.router.showPopularMovies()
        case .nowPlaying:
            self.router.showNowPlayingMovies()
        case .upcoming:
            self.router.showUpcomingMovies()
        case .topRated:
            self.router.showTopRatedMovies()
        }
    }
    
}
