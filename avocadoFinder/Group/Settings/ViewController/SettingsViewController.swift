//
//  SettingsViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 4/20/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!

    // - Manager
    fileprivate var dataSource: SettingsDataSource!
    private var cellConfigurator: SettingsCellConfigurator!

    
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
// MARK: - Navigation

extension SettingsViewController: SettingsDataSourceDelegate {
    
    func didTapOnCell(value: String) {
        openStaticPage(value: value)
    }
    
    func openStaticPage(value: String) {
        switch value {
        case AppDocuments.privacyPolicy.rawValue:
            UIApplication.shared.open(NSURL(string: AppDocuments.privacyPolicy.urlForDocument)! as URL, options: [:], completionHandler: nil)
        case AppDocuments.termsAndCondition.rawValue:
            UIApplication.shared.open(NSURL(string: AppDocuments.termsAndCondition.urlForDocument)! as URL, options: [:], completionHandler: nil)
        default:
            break
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension SettingsViewController {
    
    func configure() {
        setupCellConfigurator()
        configureDataSource()
        configureTableView()
    }
    
    func configureDataSource() {
        dataSource = SettingsDataSource(tableView: tableView, cellItems: cellConfigurator.configure())
        dataSource.delegate = self
    }
    
    func setupCellConfigurator() {
        cellConfigurator = SettingsCellConfigurator()
    }
    
    func configureTableView() {
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
    }
    
}
