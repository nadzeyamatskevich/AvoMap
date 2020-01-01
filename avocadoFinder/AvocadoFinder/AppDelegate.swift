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
        //var tabBarController: RAMAnimatedTabBarController?
        
        let mainController = UIStoryboard(storyboard: .main).instantiateInitialViewController() as? MainViewController
       
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let main = mainController {
            let navigationController = UINavigationController(rootViewController: main)
            navigationController.navigationBar.isTranslucent = false
            navigationController.setNavigationBarHidden(true, animated: false)
            rootNavigationController = navigationController
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
    }
    
}

