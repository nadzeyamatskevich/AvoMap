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
    private unowned let viewController: NewsAndBlogViewController
    
    // - Manager
    private let userDefaultsManager = UserDefaultsManager()
    
    init(viewController: NewsAndBlogViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
    func viewWillAppear(_ animated: Bool) {
        getServerData()
    }
    
}

// MARK: -
// MARK: - Server

extension NewsAndBlogLayoutManager {
    
    func getNews() {
        viewController.getNewsRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
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
    
    func getServerData() {
        getNews()
    }
    
    func configure() {
        let type = userDefaultsManager.get(data: .type)
        let image = type == "\(TypeOfFruit.mango)" ?  #imageLiteral(resourceName: "mangoNavBar") : #imageLiteral(resourceName: "newsNavBarBg")
        viewController.navBarBgImageView.image = image
    }
    
}
