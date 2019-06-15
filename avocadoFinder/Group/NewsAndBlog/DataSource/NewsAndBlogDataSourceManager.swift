//
//  NewsAndBlogDataSourceManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class NewsAndBlogDataSourceManager: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView
    
    // - Delegate
    weak var delegate: NewsAndBlogDataSourceDelegate?
    
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

extension NewsAndBlogDataSourceManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return newsCell(for: indexPath)
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension NewsAndBlogDataSourceManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapOnCell(post: indexPath.row)
    }
    
}

// MARK: -
// MARK: - Cell

extension NewsAndBlogDataSourceManager {
    
    func newsCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.newsCell, for: indexPath) as! NewsAndBlogTableViewCell
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

extension NewsAndBlogDataSourceManager {
    
    struct Cell {
        static let newsCell = "NewsAndBlogTableViewCell"
    }
    
    func configure() {
        setupDelegates()
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}
