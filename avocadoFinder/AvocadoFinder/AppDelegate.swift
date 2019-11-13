//
//  AppDelegate.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/19/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RAMAnimatedTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var application: UIApplication?
    weak var rootNavigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSPlacesClient.provideAPIKey("AIzaSyA4eeMxsmUH9GUG_H_4gEuO2qJyRvANi7s")
        GMSServices.provideAPIKey("AIzaSyA4eeMxsmUH9GUG_H_4gEuO2qJyRvANi7s")
        
        setupRootViewController()
        self.application = application
        return true
    }

    func setupRootViewController() {
        var tabBarController: RAMAnimatedTabBarController?
        
        tabBarController = UIStoryboard(storyboard: .tabBar).instantiateInitialViewController() as? RAMAnimatedTabBarController
       
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let tabBar = tabBarController {
            let navigationController = UINavigationController(rootViewController: tabBar)
            navigationController.navigationBar.isTranslucent = false
            navigationController.setNavigationBarHidden(true, animated: false)
            rootNavigationController = navigationController
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
    }
    
}

