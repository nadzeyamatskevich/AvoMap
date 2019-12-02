//
//  ViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/19/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    // - UI
    @IBOutlet weak var avoMapView: GMSMapView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var contentTypeControl: UISegmentedControl!
    
    // - Manager
    private var layoutManager: MapLayoutManager!
    private var coordinatorManager: MapCoordinatorManager!
    private var serverManager = MapServerManager()
    
    // - Data
    var shops: [ShopModel] = []
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        layoutManager.getShops()
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
        coordinatorManager.pushLitsOfPlacesViewController(shops: [], switchState: contentTypeControl.selectedSegmentIndex)
    }
    
    @IBAction func addNewPlaceButtonAction(_ sender: Any) {
        coordinatorManager.pushAddNewPlaceViewController()
    }
    
    @IBAction func changeContentTypeAction(_ sender: Any) {
        layoutManager.updateMapViewData()
    }
    
    func openPlaceInfo(shop: ShopModel) {
        coordinatorManager.pushPlaceViewController(shop: shop)
    }
    
    func openPlaceList(shops: [ShopModel]) {
        coordinatorManager.pushLitsOfPlacesViewController(shops: shops, switchState: contentTypeControl.selectedSegmentIndex)
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
    }
    
    func configureLayoutManager() {
        layoutManager = MapLayoutManager(viewController: self)
    }
    
    func configureCoordinatorManager() {
        coordinatorManager = MapCoordinatorManager(viewController: self)
    }
    
}
