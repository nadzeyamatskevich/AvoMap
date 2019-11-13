//
//  NewsAndBlogLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import HPGradientLoading

class NewsAndBlogLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: NewsAndBlogViewController
    
    init(viewController: NewsAndBlogViewController) {
        self.viewController = viewController
        super.init()
        configureLoader()
    }
    
    func viewWillAppear(_ animated: Bool) {
        getServerData()
    }
    
}

// MARK: -
// MARK: - Server

extension NewsAndBlogLayoutManager {
    
    func getNews() {
        HPGradientLoading.shared.showLoading()
        viewController.getNewsRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                HPGradientLoading.shared.dismiss()
                strongSelf.viewController.showAlert(title: "Упс, ошибка", message: "Попорбуйте позже")
            } else if let response = response {
                strongSelf.viewController.updateData(news: response)
                HPGradientLoading.shared.dismiss()
            }
        }
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension NewsAndBlogLayoutManager {
    
    func getServerData() {
        getNews()
    }
    
    func configureLoader() {
        viewController.configureLoader()
    }
    
}
