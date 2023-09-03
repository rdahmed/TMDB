//
//  MainCoordinator.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import UIKit

class MainCoordinator {
    
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.navigationController = DefaultNavigationController()
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func run() {
        let viewModel = CategoriesMenuViewModel(router: self)
        let viewController = CategoriesMenuViewController(viewModel: viewModel)
                
        self.navigationController.viewControllers = [viewController]
    }
    
}

// MARK: - CategoriesMenuRouter

extension MainCoordinator: CategoriesMenuRouter {
    
    func showPopularMovies() {
        let viewModel = MoviesListViewModel(category: .popular, router: self)
        let viewController = MoviesListViewController(viewModel: viewModel)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showNowPlayingMovies() {
        let viewModel = MoviesListViewModel(category: .nowPlaying, router: self)
        let viewController = MoviesListViewController(viewModel: viewModel)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showUpcomingMovies() {let viewModel = MoviesListViewModel(category: .upcoming, router: self)
        let viewController = MoviesListViewController(viewModel: viewModel)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showTopRatedMovies() {
        let viewModel = MoviesListViewModel(category: .topRated, router: self)
        let viewController = MoviesListViewController(viewModel: viewModel)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - MoviesListRouter

extension MainCoordinator: MoviesListRouter {
    
    func showMovieDetails(_ id: Int) {
        // TODO: Route to movie details
    }
    
}
