//
//  RecipesLayoutManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class RecipesLayoutManager: NSObject {
    
    // - UI
    private unowned let viewController: RecipesViewController
    
    // - Manager
    private let userDefaultsManager = UserDefaultsManager()
    
    init(viewController: RecipesViewController) {
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

private extension RecipesLayoutManager {
    
    func getRecipes() {
        viewController.getRecipesRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.viewController.showAlert(title: "Упс, ошибка", message: "Попорбуйте позже")
            } else if let response = response {
                strongSelf.viewController.updateData(recipes: response)
            }
        }
    }
    
}

// MARK: -
// MARK: - Configure

private extension RecipesLayoutManager {
    
    func getServerData() {
        getRecipes()
    }
    
    func configure() {
        let type = userDefaultsManager.get(data: .type)
        let image = type == "\(TypeOfFruit.mango)" ?  #imageLiteral(resourceName: "mangoNavBar") : #imageLiteral(resourceName: "HeaderRecipes")
        viewController.navBarBgImageView.image = image
    }
    
}
