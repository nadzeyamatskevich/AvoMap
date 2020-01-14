//
//  RecipesDataSourceManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class RecipesDataSourceManager: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView
    
    // - Delegate
    weak var delegate: RecipesDataSourceDelegate?
    
    // - Data
    var recipes: [RecipeModel] = []
    
    // - Lifecycle
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
    func update() {
        tableView.reloadData()
    }
    
}

// MARK: -
// MARK: - UITableViewDataSource

extension RecipesDataSourceManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return newsCell(for: indexPath)
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension RecipesDataSourceManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? NewsAndBlogTableViewCell
        delegate?.didTapOnCell(recipe: recipes[indexPath.row], image: cell?.avoImage.image)
    }
    
}

// MARK: -
// MARK: - Cell

extension RecipesDataSourceManager {
    
    func newsCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.recipe, for: indexPath) as! RecipeTableViewCell
        cell.set(recipe: recipes[indexPath.row])
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

extension RecipesDataSourceManager {
    
    struct Cell {
        static let recipe = "Recipe"
    }
    
    func configure() {
        setupDelegates()
    }
    
    func setupDelegates() {
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 20, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }

}
