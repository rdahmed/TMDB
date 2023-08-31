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
        // TODO: Route to popular movies list
    }
    
    func showNowPlayingMovies() {
        // TODO: Route to now playing movies list
    }
    
    func showUpcomingMovies() {
        // TODO: Route to upcoming movies list
    }
    
    func showTopRatedMovies() {
        // TODO: Route to top rated movies list
    }
    
}
