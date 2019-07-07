//
//  NewsAndBlogLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class NewsAndBlogLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: NewsAndBlogViewController
    
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
                print(error)
                strongSelf.viewController.showAlert(title: "Упс, ошибка", message: "Попорбуйте позже")
            } else if let response = response {
                strongSelf.viewController.updateData(news: response)
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
