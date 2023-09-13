//
//  AppDelegate.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        Reachability.shared.start()
        return true
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TMDB")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription, error.userInfo)
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext(_ entityName: String?, data: [String: Any?]) {
        let context = self.persistentContainer.viewContext
        
        guard
            let entityName,
            let entity = NSEntityDescription.entity(
            forEntityName: entityName,
            in: context
        ) else { return }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        
        data.keys.forEach {
            if let value = data[$0] {
                object.setValue(value, forKey: $0)
            }
        }
                
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
