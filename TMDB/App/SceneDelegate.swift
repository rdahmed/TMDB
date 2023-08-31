//
//  SceneDelegate.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        MainCoordinator(window: window).run()
        
        self.window = window
    }

}
