//
//  VolutesViewController.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class VolutesViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - Manager
    fileprivate var dataSource: VolutesDataSourceManager!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

// MARK: -
// MARK: - Data source delegate

extension VolutesViewController: VolutesDataSourceDelegate {
    
    func didTapOnCell(volute: String) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: -
// MARK: - Configure

extension VolutesViewController {
    
    func configure() {
        configureDataSource()
    }
    
    func configureDataSource() {
        dataSource = VolutesDataSourceManager(tableView: tableView)
//        dataSource.delegate = self
    }
    
}
