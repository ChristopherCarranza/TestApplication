//
//  AppDelegate.swift
//  Test Application
//
//  Created by Christopher Carranza on 6/24/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit
import Dip

typealias UserRepository = Repository<User>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var dependencyContainer: DependencyContainer!

    var window: UIWindow? = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Registeres everything in the dependency container
        setupDependencyContainer()
        
        // Completes the container setup and doesn't allow anything else to be added
        try! dependencyContainer.bootstrap()
        
        let mainViewControllerFactory: MainViewControllerFactory = try! dependencyContainer.resolve()
        
        window?.rootViewController = UINavigationController(rootViewController: mainViewControllerFactory.create())
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func setupDependencyContainer() {
        dependencyContainer = DependencyContainer { (container) in
            container.register(.singleton) { UserDefaults.standard }
            container.register(.singleton) { UIApplication.shared }
            container.register(.singleton) { UserRepository(storage: $0) }
            container.register { UserDefaultsUserStorage(userDefaults: $0) as PersistantStorage }
            container.register { MainViewModelFactory(userRepository: $0) }
            container.register { MainViewControllerFactory(viewModelFactory: $0, addViewControllerFactory: $1) }
            container.register { AddViewModelFactory(userRepository: $0) }
            container.register { AddViewControllerFactory(viewModelFactory: $0) }
        }
    }


}

