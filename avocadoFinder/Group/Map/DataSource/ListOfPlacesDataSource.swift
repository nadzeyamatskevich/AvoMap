//
//  ListOfPlacesDataSource.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/1/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class ListOfPlacesDataSource: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView
    
    // - Delegate
    weak var delegate: MapDelegate?
    
    // - Data
    var shops: [ShopModel] = []
    
    // - Lifecycle
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func set(shops: [ShopModel]) {
        self.shops = shops
        tableView.reloadData()
    }
    
}

// MARK: -
// MARK: - UITableViewDataSource

extension ListOfPlacesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
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
        delegate?.didTapOnCell(shop: shops[indexPath.row])
    }
    
}

// MARK: -
// MARK: - Cell

extension ListOfPlacesDataSource {
    
    func shopCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.shopCell, for: indexPath) as! ListOfPlacesTableViewCell
        cell.set(shop: shops[indexPath.row])
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
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
