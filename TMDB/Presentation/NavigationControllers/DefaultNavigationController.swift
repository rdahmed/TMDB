//
//  DefaultNavigationController.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import UIKit

class DefaultNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupAppearance()
    }
    
    private func setupAppearance() {
        self.view.backgroundColor = .white
        
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .accentColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backButtonAppearance = backButtonAppearance
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.tintColor = .white
        self.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
}
