//
//  ListOfPlacesDataSource.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class ListOfPlacesDataSource: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView
    
    // - Delegate
    weak var delegate: ListOfPlacesDataSourceDelegate?
    
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

extension ListOfPlacesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return shopCell(for: indexPath)
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension ListOfPlacesDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapOnCell(shop: indexPath.row)
    }
    
}

// MARK: -
// MARK: - Cell

extension ListOfPlacesDataSource {
    
    func shopCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.shopCell, for: indexPath) as! ListOfPlacesTableViewCell
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

extension ListOfPlacesDataSource {
    
    struct Cell {
        static let shopCell = "ListOfPlacesTableViewCell"
    }
    
    func configure() {
        setupDelegates()
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
