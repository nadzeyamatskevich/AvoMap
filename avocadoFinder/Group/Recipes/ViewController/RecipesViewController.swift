//
//  RecipesViewController.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - Manager
    fileprivate var layoutManager: RecipesLayoutManager!
    fileprivate var dataSource: RecipesDataSourceManager!
    fileprivate var coordinatorManager: RecipesCoordinatorManager!
    fileprivate var serverManager = RecipesServerManager()
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        layoutManager.viewWillAppear(animated)
        AppUpdater.shared.showUpdate(withConfirmation: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

// MARK: -
// MARK: - Data source delegate

extension RecipesViewController: RecipesDataSourceDelegate {
    
    func didTapOnCell(recipe: RecipeModel, image: UIImage?) {
        coordinatorManager.pushRecipeInfoViewController(recipe: recipe, image: image)
    }
    
}

// MARK: -
// MARK: - Server

extension RecipesViewController {
    
    func getRecipesRequest(completion: @escaping ((_ successModel: [RecipeModel]?, _ error: ErrorModel?) -> ())) {
        serverManager.getRecipes(completion: completion)
    }
    
    func updateData(recipes: [RecipeModel]) {
        dataSource.recipes = recipes
        dataSource.update()
    }
    
}

// MARK: -
// MARK: - Configure

extension RecipesViewController {
    
    func configure() {
        configureLayoutManager()
        configureDataSource()
        configureCoordinatorManager()
    }
    
    func configureLayoutManager() {
        layoutManager = RecipesLayoutManager(viewController: self)
    }
    
    func configureCoordinatorManager() {
        coordinatorManager = RecipesCoordinatorManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = RecipesDataSourceManager(tableView: tableView)
        dataSource.delegate = self
    }
    
}
