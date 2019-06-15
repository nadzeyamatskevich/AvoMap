//
//  PlaceInfoViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class PlaceInfoViewController: UIViewController {

    // - UI
    @IBOutlet weak var tableVIew: UITableView!
    
    // - Manager
    //fileprivate var layoutManager: ShoppingListMenuLayoutManager!
    fileprivate var dataSource: PlaceInfoDataSource!
    
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
    
    // - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: -
// MARK: - Data source delegate

extension PlaceInfoViewController: ListOfPlacesDataSourceDelegate {
    func didTapOnCell(shop: Int) {
        let placeInfoViewController = UIStoryboard(storyboard: .placeInfo).instantiateInitialViewController() as! PlaceInfoViewController
        self.navigationController?.pushViewController(placeInfoViewController, animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

extension PlaceInfoViewController {
    
    func configure() {
        configureLayoutManager()
        configureDataSource()
    }
    
    func configureLayoutManager() {
        //layoutManager = ShoppingListMenuLayoutManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = PlaceInfoDataSource(tableView: tableVIew)
        dataSource.delegate = self
    }
    
}

