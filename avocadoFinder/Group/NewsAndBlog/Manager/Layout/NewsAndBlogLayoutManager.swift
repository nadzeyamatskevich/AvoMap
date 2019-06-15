//
//  NewsAndBlogLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps

class NewsAndBlogLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: NewsAndBlogViewController
    
    // - Manager
    private let locationManager = CLLocationManager()
    
    init(viewController: NewsAndBlogViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
    func viewWillAppear(_ animated: Bool) {
    }
    
}

// MARK: -
// MARK: - Server

extension NewsAndBlogLayoutManager {
    
    func getNews() {
        viewController.getNewsRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Error")
            } else if let response = response {
                print("RESPONSE", response)
            }
        }
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension NewsAndBlogLayoutManager {
    
    func configure() {
        getServerData()
    }
    
    func getServerData() {
        getNews()
    }
}
