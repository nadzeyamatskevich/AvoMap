//
//  CurrenciesViewController.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class CurrenciesViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    // - Manager
    fileprivate var dataSource: CurrenciesDataSource!
    
    // - Delegate
    var addNewPlaceDelegate: AddNewPlaceDelegate?
    
    // - Data
    private(set) var currencies: [CurrencyModel] = []
    private(set) var selectedСurrency: String = "BYN"
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        presentAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        mainView.isHidden = true
        dismiss(animated: true, completion: nil)
    }

}

// MARK: -
// MARK: - Configure

extension CurrenciesViewController {
    
    func configure() {
        configureDataSource()
        setupPlacehoder()
        textField.delegate = self
    }
    
    func presentAnimation() {
        self.mainView.alpha = 0
        self.mainView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.35, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.mainView.transform = .identity
            self?.mainView.alpha = 1
            }, completion: nil)
    }
    
    func setupPlacehoder() {
        textField.attributedPlaceholder = NSAttributedString(string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func configureDataSource() {
        dataSource = CurrenciesDataSource(tableView: tableView)
        let currencies = CurrencyManager.shared.currencies
        self.currencies = currencies
        self.selectedСurrency = CurrencyManager.shared.selectedСurrency
        dataSource.update(currencies, selectedСurrency)
        dataSource.addNewPlaceDelegate = addNewPlaceDelegate
        dataSource.mainDelegate = self
    }
    
    func search(searchText: String) {
        let data = currencies
        var filteredData:[CurrencyModel] = []
        if  searchText.isEmpty {
            dataSource.update(data)
            tableView.reloadData()
            return
        }
        filteredData = data.filter({$0.name.lowercased().contains(searchText.lowercased()) || $0.currency.lowercased().contains(searchText.lowercased())})
        dataSource.update(filteredData)
    }
    
}

// MARK: -
// MARK: - CurrenciesDataSourceDelegate

extension CurrenciesViewController: CurrenciesDataSourceDelegate {
    
    func didTapOnCell() {
        mainView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: -
// MARK: - UITextFieldDelegate

extension CurrenciesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        search(searchText: textField.text ?? "")
        return true
    }
    
}
