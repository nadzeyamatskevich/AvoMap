//
//  VolutesDataSourceManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class VolutesDataSourceManager: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView
    
    // - Delegate
    weak var delegate: VolutesDataSourceDelegate?
    
    // - Data
    var volutes: [String] = ["Доллар США", "Белорусский рубль", "Российский рубль", "Евро", "Украинская гривна", "Фунт стерлингов", "Злотый", "Шведская крона", "Турецкая лира", "Болгарский лев", "Казахстанский тенге", "Японская йена", "Канадский доллар"]
    
    var keys: [String] = ["USD", "BYN", "RUB", "EUR", "UAH", "GBP", "PLN", "SEK", "TRY", "BGN", "KZT", "JPY", "CAD"]
    
    var flags: [UIImage] = [#imageLiteral(resourceName: "USA"), #imageLiteral(resourceName: "Belarus"), #imageLiteral(resourceName: "Russia"), #imageLiteral(resourceName: "Europe"), #imageLiteral(resourceName: "Ukraine"), #imageLiteral(resourceName: "UK"), #imageLiteral(resourceName: "Poland"), #imageLiteral(resourceName: "Sweden"), #imageLiteral(resourceName: "Turkey"), #imageLiteral(resourceName: "Bulgaria"), #imageLiteral(resourceName: "Kazakhstan"), #imageLiteral(resourceName: "Japan"), #imageLiteral(resourceName: "Canada")]
    
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

extension VolutesDataSourceManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return voluteCell(for: indexPath)
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension VolutesDataSourceManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapOnCell(volute: volutes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
}

// MARK: -
// MARK: - Cell

extension VolutesDataSourceManager {
    
    func voluteCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.volute, for: indexPath) as! VoluteTableViewCell
        cell.set(key: keys[indexPath.row], title: volutes[indexPath.row], image: flags[indexPath.row])
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

extension VolutesDataSourceManager {
    
    struct Cell {
        static let volute = "Volute"
    }
    
    func configure() {
        tableView.tableFooterView = UIView(frame: .zero)
        setupDelegates()
    }
    
    func setupDelegates() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }

}
