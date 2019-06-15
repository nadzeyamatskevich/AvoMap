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
    private let locationManager = CLLocationManager()
    
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
        pushLitsOfPlacesViewController()
    }
    
    @IBAction func addNewPlaceButtonAction(_ sender: Any) {
        pushAddNewPlaceViewController()
    }
    
    func pushLitsOfPlacesViewController() {
        let listOfPlacesViewController = UIStoryboard(storyboard: .listOfPlaces).instantiateInitialViewController() as! ListOfPlacesViewController
        self.navigationController?.pushViewController(listOfPlacesViewController, animated: true)
    }
    
    func pushAddNewPlaceViewController() {
        let addNewPlaceViewController = UIStoryboard(storyboard: .addNewPlace).instantiateInitialViewController() as! AddNewPlaceViewController
        self.navigationController?.pushViewController(addNewPlaceViewController, animated: true)
    }
    
}


// MARK: - CLLocationManagerDelegate
//

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        
        avoMapView.isMyLocationEnabled = true
        avoMapView.settings.myLocationButton = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        
        avoMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - Configure
//

extension MapViewController {
    
    func configure() {
        configureMapDelegate()
        configureSaveButton()
    }
    
    func configureMapDelegate() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 40
        saveButton.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
}
