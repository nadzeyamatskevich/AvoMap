//
//  AddNewPlaceDataSourceManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AddNewPlaceDataSourceManager: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView
    
    // - Delegate
    weak var delegate: AddNewPlaceDelegate?
    
    // - Data
    private(set) var cells: [Cell] = []
    private(set) var userName: String = ""
    private(set) var address: String = ""
    private(set) var name: String = ""
    private(set) var comment: String = ""
    
    // - Lifecycle
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
    func set(userName: String) {
        self.userName = userName
        configureCells()
        tableView.reloadData()
    }
    
    func setAddress(_ address: String) {
        self.address = address
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddNewPlaceMainTableViewCell
        cell?.setAddress(address)
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func changeType(isAVO: Bool) {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddNewPlaceDescriptionTableViewCell
        cell?.changeType(isAVO: isAVO)
        let saveCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? AddNewPlaceSaveTableViewCell
        saveCell?.changeType(isAVO: isAVO)
    }
    
}

// MARK: -
// MARK: - UITableViewDataSource

extension AddNewPlaceDataSourceManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
            case .main:            return mainCell(for: indexPath)
            case .mainWithoutName: return mainWithoutNameCell(for: indexPath)
            case .description:     return descriptionCell(for: indexPath)
            case .save:            return saveCell(for: indexPath)
        }
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension AddNewPlaceDataSourceManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: -
// MARK: - Cell

extension AddNewPlaceDataSourceManager {
    
    func mainCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.main.rawValue, for: indexPath) as! AddNewPlaceMainTableViewCell
        return cell
    }
    
    func mainWithoutNameCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.mainWithoutName.rawValue, for: indexPath) as! AddNewPlaceMainTableViewCell
        return cell
    }
    
    func descriptionCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.description.rawValue, for: indexPath) as! AddNewPlaceDescriptionTableViewCell
        return cell
    }
    
    func saveCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.save.rawValue, for: indexPath) as! AddNewPlaceSaveTableViewCell
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

extension AddNewPlaceDataSourceManager {
    
    enum Cell: String {
        case main = "Main"
        case mainWithoutName = "MainWithoutName"
        case description = "Description"
        case save = "Save"
    }
    
    func configure() {
        configureCells()
        setupDelegates()
    }
    
    func configureCells() {
        cells = userName.isEmpty ? [.main, .description, .save] : [.mainWithoutName, .description, .save]
    }
    
    func setupDelegates() {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }

}
