//
//  SettingsDataSource.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/13/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class SettingsDataSource: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView
    
    // - Delegate
    weak var delegate: SettingsDataSourceDelegate?
    
    // - Data
    var cellItems: [SettingsCellViewModel]
    
    // - Lifecycle
    init(tableView: UITableView, cellItems: [SettingsCellViewModel]) {
        self.tableView = tableView
        self.cellItems = cellItems
        super.init()
        configure()
    }
    
    func update() {
        tableView.reloadData()
    }
    
}

// MARK: -
// MARK: - UITableViewDataSource

extension SettingsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellItems[indexPath.row].type {
        case .author:
            return authorCell(for: indexPath)
        case .info:
            return infoCell(for: indexPath)
        }
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension SettingsDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellItems[indexPath.row].type {
        case .info:
            delegate?.didTapOnCell(value: cellItems[indexPath.row].value)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
}

// MARK: -
// MARK: - Cell

extension SettingsDataSource {
    
    func authorCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCellType.author.rawValue, for: indexPath) as! AuthorSettingsCell
        cell.set(value: cellItems[indexPath.row].value)
        return cell
    }
    
    func infoCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCellType.info.rawValue, for: indexPath) as! TermsInfoSettingsCell
        cell.set(value: cellItems[indexPath.row].value)
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

extension SettingsDataSource {
    
    func configure() {
        setupDelegates()
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
