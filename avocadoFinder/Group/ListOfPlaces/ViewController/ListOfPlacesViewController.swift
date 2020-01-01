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
    @IBOutlet weak var plusView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findYourAvocadoLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var contentTypeControl: UISegmentedControl!
    
    // - Constraint
    @IBOutlet weak var segmentControlWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusRightConstraint: NSLayoutConstraint!
    
    // - Manager
    fileprivate var dataSource: ListOfPlacesDataSource!
    fileprivate var serverManager = MapServerManager()
    
    // - Data
    var shops: [ShopModel] = []
    var switchState: Int = 0
    var isHideControl: Bool = false
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTypeControl.selectedSegmentIndex = switchState
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureSegmentControlWidth()
        hideSegmentControl()
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
        showButtonsAnimation()
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
    
    func showButtonsAnimation() {
        plusView.isHidden = false
        filterView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.1, animations: { [weak self] in
            guard let self = self else { return }
            self.filterBottomConstraint.constant = -80
            self.filterLeftConstraint.constant = -80
            self.plusBottomConstraint.constant = self.contentTypeControl.selectedSegmentIndex == 0 ? -80 : -160
            self.plusRightConstraint.constant = self.contentTypeControl.selectedSegmentIndex == 0 ? -80 : -160
            self.view.layoutIfNeeded()
        }, completion: nil)
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
        configureButtons()
    }
    
    func configureButtons() {
        self.filterBottomConstraint.constant = -160
        self.filterLeftConstraint.constant = -160
        self.plusBottomConstraint.constant = -160
        self.plusRightConstraint.constant = -160
    }
    
    func getServerData() {
        shops.count == 0 ? getShops() : updateTableViewData()
    }
    
    func hideSegmentControl() {
        if isHideControl == false { return }
        findYourAvocadoLabel.isHidden = false
        contentTypeControl.isHidden = true
    }
    
    func configureDataSource() {
        dataSource = ListOfPlacesDataSource(tableView: tableView)
        dataSource.delegate = self
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 30
        saveButton.setupShadow(color: AppColor.black(alpha: 0.2))
    }
    
    func configureSegmentControlWidth() {
        var attributes: [NSAttributedString.Key : NSObject] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.white
        switch UIScreen.main.bounds.height {
            case ...568:
                segmentControlWidthConstraint.constant = 180
                attributes[NSAttributedString.Key.font] = AppFont.bold(size:15)
            case 667...736:
                segmentControlWidthConstraint.constant = 200
                attributes[NSAttributedString.Key.font] = AppFont.bold(size:16)
            default:
                segmentControlWidthConstraint.constant = 235
                attributes[NSAttributedString.Key.font] = AppFont.bold(size:18)
        }
        contentTypeControl.setTitleTextAttributes(attributes, for: .normal)
        contentTypeControl.setTitleTextAttributes(attributes, for: .selected)
    }
    
}


