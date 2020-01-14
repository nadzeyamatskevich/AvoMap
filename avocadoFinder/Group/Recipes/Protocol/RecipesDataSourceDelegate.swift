//
//  RecipesDataSourceDelegate.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

protocol RecipesDataSourceDelegate: class {
    func didTapOnCell(recipe: RecipeModel, image: UIImage?)
}
