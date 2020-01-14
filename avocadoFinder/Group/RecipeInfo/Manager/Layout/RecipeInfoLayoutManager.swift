//
//  RecipeInfoLayoutManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeInfoLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: RecipeInfoViewController
    
    init(viewController: RecipeInfoViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
}


// MARK: -
// MARK: - Configure

fileprivate extension RecipeInfoLayoutManager {
    
    func configure() {
        configureImage()
    }
    
    func configureImage() {
        let url = URL(string: viewController.recipe.image_url)
        viewController.imageView.sd_setImage(with: url, placeholderImage: viewController.image)
    }
}
