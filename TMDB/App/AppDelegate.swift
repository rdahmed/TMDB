//
//  AppDelegate.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if CommandLine.arguments.contains(Accessibility.appLaunchArgument.rawValue) {
            self.resetState()
        }
        
        Reachability.shared.start()
        return true
    }
    
    private func resetState() {
        let defaultsName = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: defaultsName)
    }

    // MARK: - UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}
