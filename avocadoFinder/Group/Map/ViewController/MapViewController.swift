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
    
    // - Manager
    private var layoutManager: MapLayoutManager!
    private var coordinatorManager: MapCoordinatorManager!
    private var serverManager = MapServerManager()
    
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

// MARK: - Navigation
//

extension MapViewController {
    
    @IBAction func listOfPlacesButtonAction(_ sender: Any) {
        coordinatorManager.pushLitsOfPlacesViewController()
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

// MARK: - Configure
//

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
