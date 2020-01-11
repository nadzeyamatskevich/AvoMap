//
//  ViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/19/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class MapViewController: UIViewController {

    // - UI
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avoMapView: GMSMapView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var contentTypeControl: UISegmentedControl!
    
    // - Constraint
    @IBOutlet weak var listTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentControlWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var myLocationBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var myLocationRightConstraint: NSLayoutConstraint!
    
    // - Manager
    private var layoutManager: MapLayoutManager!
    private var coordinatorManager: MapCoordinatorManager!
    private var serverManager = MapServerManager()
    private var dataSource: ListOfPlacesDataSource!
    
    // - Data
    var shops: [ShopModel] = []
    var isListHidden = true
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        addAnalyticsEvent()
        layoutManager.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

// MARK: -
// MARK: - Navigation

extension MapViewController {
    
    @IBAction func listOfPlacesButtonAction(_ sender: Any) {
        layoutManager.listOfPlacesButtonAction()
    }
    
    @IBAction func changeContentTypeAction(_ sender: Any) {
        layoutManager.updateMapViewData()
    }
    
    func openPlaceInfo(shop: ShopModel) {
        coordinatorManager.pushPlaceViewController(shop: shop)
    }
    
    func openPlaceList(shops: [ShopModel], isHideControl: Bool = false) {
        dataSource.set(shops: shops)
        layoutManager.showList()
    }
    
    @IBAction func myLocationButtonAction(_ sender: UIButton) {
        layoutManager.myLocationButtonAction()
    }
    
    @IBAction func addNewPlaceButtonAction(_ sender: Any) {
        coordinatorManager.pushAddNewPlaceViewController()
    }
    
}

// MARK: -
// MARK: - Server

extension MapViewController {
    
    func getShopsRequest(completion: @escaping ((_ successModel: [ShopModel]?, _ error: ErrorModel?) -> ())) {
        serverManager.getShops(completion: completion)
    }
    
}

// MARK: -
// MARK: - Configure

extension MapViewController {
    
    func configure() {
        configureLayoutManager()
        configureCoordinatorManager()
        configureDataSource()
    }
    
    func configureLayoutManager() {
        layoutManager = MapLayoutManager(viewController: self)
    }
    
    func configureCoordinatorManager() {
        coordinatorManager = MapCoordinatorManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = ListOfPlacesDataSource(tableView: tableView)
        dataSource.delegate = self
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
    
    func addAnalyticsEvent() {
        Analytics.logEvent("open_map", parameters: [:])
    }
  
    
}

// MARK: -
// MARK: - Data source delegate

extension MapViewController: MapDelegate {
    func didTapOnCell(shop: ShopModel) {
        let placeInfoViewController = UIStoryboard(storyboard: .placeInfo).instantiateInitialViewController() as! PlaceInfoViewController
        placeInfoViewController.shop = shop
        self.navigationController?.pushViewController(placeInfoViewController, animated: true)
    }
    
}
