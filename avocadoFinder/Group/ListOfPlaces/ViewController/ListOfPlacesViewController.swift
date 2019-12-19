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
    @IBOutlet weak var contentTypeControl: UISegmentedControl!
    
    // - Manager
    fileprivate var dataSource: ListOfPlacesDataSource!
    fileprivate var serverManager = MapServerManager()
    
    // - Data
    var shops: [ShopModel] = []
    var switchState: Int = 0
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTypeControl.selectedSegmentIndex = switchState
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        getServerData()
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
    
    @IBAction func swithContent(_ sender: Any) {
        updateTableViewData()
    }
    
    func updateTableViewData() {
        switch self.contentTypeControl.selectedSegmentIndex {
        case 0:
            self.saveButton.isHidden = false
            dataSource.shops = shops.filter {$0.type == "store"}
        default:
            self.saveButton.isHidden = true
            dataSource.shops = shops.filter {$0.type == "food_establishment"}
        }
        tableView.reloadData()
    }
    
    func pushAddNewPlaceViewController() {
        let addNewPlaceViewController = UIStoryboard(storyboard: .addNewPlace).instantiateInitialViewController() as! AddNewPlaceViewController
        self.navigationController?.pushViewController(addNewPlaceViewController, animated: true)
    }
    
}

// MARK: -
// MARK: - Data source delegate

extension ListOfPlacesViewController: ListOfPlacesDataSourceDelegate {
    func didTapOnCell(shop: ShopModel) {
        let placeInfoViewController = UIStoryboard(storyboard: .placeInfo).instantiateInitialViewController() as! PlaceInfoViewController
        placeInfoViewController.shop = shop
        self.navigationController?.pushViewController(placeInfoViewController, animated: true)
    }
    
}

// MARK: -
// MARK: - Server

extension ListOfPlacesViewController {
    
    func getShopsRequest(completion: @escaping ((_ successModel: [ShopModel]?, _ error: ErrorModel?) -> ())) {
        serverManager.getShops(completion: completion)
    }
    
    func getShops() {
        getShopsRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                self?.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if let response = response {
                strongSelf.shops = response
                strongSelf.updateTableViewData()
            }
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension ListOfPlacesViewController {
    
    func configure() {
        configureDataSource()
        configureSaveButton()
        getServerData()
    }
    
    func getServerData() {
        shops.count == 0 ? getShops() : updateTableViewData()
    }
    
    func configureDataSource() {
        dataSource = ListOfPlacesDataSource(tableView: tableView)
        dataSource.delegate = self
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 30
        saveButton.setupShadow(color: AppColor.black(alpha: 0.2))
    }
    
}


