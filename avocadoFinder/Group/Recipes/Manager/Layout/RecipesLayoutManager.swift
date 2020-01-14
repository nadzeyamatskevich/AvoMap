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
    fileprivate unowned let viewController: RecipesViewController
    
    init(viewController: RecipesViewController) {
        self.viewController = viewController
        super.init()
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
    
}
