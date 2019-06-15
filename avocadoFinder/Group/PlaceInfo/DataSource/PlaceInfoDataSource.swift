//
//  PlaceInfoDataSource.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class PlaceInfoDataSource: NSObject {
    
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

extension PlaceInfoDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return maimInfoCell(for: indexPath)
        case 1:
            return addCommentCell(for: indexPath)
        default:
            return commentCell(for: indexPath)
        }
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension PlaceInfoDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //delegate?.didTapOnCell(shop: indexPath.row)
    }
    
}

// MARK: -
// MARK: - Cell

extension PlaceInfoDataSource {
    
    func maimInfoCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.mainInfoCell, for: indexPath) as! PlaceInfoMainInfoTableViewCell
        return cell
    }
    
    func addCommentCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.addCommentCell, for: indexPath) as! PlaceInfoAddCommentTableViewCell
        return cell
    }
    
    func commentCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.commetnCell, for: indexPath) as! PlaceInfoCommentTableViewCell
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

extension PlaceInfoDataSource {
    
    struct Cell {
        static let mainInfoCell = "PlaceInfoMainInfoTableViewCell"
        static let addCommentCell = "PlaceInfoAddCommentTableViewCell"
        static let commetnCell = "PlaceInfoCommentTableViewCell"
    }
    
    func configure() {
        setupDelegates()
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
