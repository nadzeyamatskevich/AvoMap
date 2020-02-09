//
//  VolutesDataSourceManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class CurrenciesDataSource: NSObject {
    
    // - Init
    private let tableView: UITableView
    
    // - Delegate
    var addNewPlaceDelegate: AddNewPlaceDelegate?
    var mainDelegate: CurrenciesDataSourceDelegate?
    
    // - Data
    private(set) var currencies: [CurrencyModel] = []
    private(set) var selectedСurrency: String = "BYR"
    
    // - Lifecycle
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
}

// MARK: - Update

extension CurrenciesDataSource {

    func update(_ currencies: [CurrencyModel], _ selectedСurrency: String = "") {
        if selectedСurrency.isEmpty == false {
            self.selectedСurrency = selectedСurrency
        }
        self.currencies = currencies
        if tableView.visibleCells.count > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        tableView.reloadData()
    }
    
}

// MARK: - UITableView Data Source

extension CurrenciesDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return currencyCell(cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - UITableView Delegate

extension CurrenciesDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        addNewPlaceDelegate?.setCurreny(currency: currencies[indexPath.row])
        mainDelegate?.didTapOnCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return 41
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - Cell

private extension CurrenciesDataSource {
    
    func currencyCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.currency, for: indexPath) as! CurrencyTableViewCell
        cell.set(currency: currencies[indexPath.row], selectedСurrency: selectedСurrency)
        return cell
    }

    
}

// MARK: - Configure

private extension CurrenciesDataSource {
    
    func configure() {
        setupDataSource()
    }
    
    func setupDataSource() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    struct Cell {
        static let currency = "Currency"
    }
    
}
