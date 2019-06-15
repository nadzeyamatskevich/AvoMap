//
//  ListOfPlacesViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/30/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class ListOfPlacesViewController: UIViewController {

    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    // - Manager
    //fileprivate var layoutManager: ShoppingListMenuLayoutManager!
    fileprivate var dataSource: ListOfPlacesDataSource!
    
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
// MARK: - Actions

extension ListOfPlacesViewController {
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewPlaceButtonAction(_ sender: Any) {
        pushAddNewPlaceViewController()
    }
    
    func pushAddNewPlaceViewController() {
        let addNewPlaceViewController = UIStoryboard(storyboard: .addNewPlace).instantiateInitialViewController() as! AddNewPlaceViewController
        self.navigationController?.pushViewController(addNewPlaceViewController, animated: true)
    }
    
}

// MARK: -
// MARK: - Data source delegate

extension ListOfPlacesViewController: ListOfPlacesDataSourceDelegate {
    func didTapOnCell(shop: Int) {
        let placeInfoViewController = UIStoryboard(storyboard: .placeInfo).instantiateInitialViewController() as! PlaceInfoViewController
        self.navigationController?.pushViewController(placeInfoViewController, animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

extension ListOfPlacesViewController {
    
    func configure() {
        configureLayoutManager()
        configureDataSource()
        configureSaveButton()
    }
    
    func configureLayoutManager() {
        //layoutManager = ShoppingListMenuLayoutManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = ListOfPlacesDataSource(tableView: tableView)
        dataSource.delegate = self
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 40
        saveButton.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
}


