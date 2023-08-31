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
    
    func run() {}
}
