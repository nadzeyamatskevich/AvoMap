//
//  RecipesCoordinatorManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class RecipesCoordinatorManager {
    
    // - UI
    private unowned var viewController: RecipesViewController
    
    init(viewController: RecipesViewController) {
        self.viewController = viewController
    }
    
    func pushRecipeInfoViewController(recipe: RecipeModel, image: UIImage?) {
        let recipeInfoVC = UIStoryboard(storyboard: .recipeInfo).instantiateInitialViewController() as! RecipeInfoViewController
        recipeInfoVC.set(recipe: recipe, image: image)
        viewController.navigationController?.pushViewController(recipeInfoVC, animated: true)
    }
    
}
