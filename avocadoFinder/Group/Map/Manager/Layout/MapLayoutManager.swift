//
//  MapLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps

class MapLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: MapViewController
    
    // - Manager
    private let locationManager = CLLocationManager()
    
    init(viewController: MapViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
    func viewWillAppear(_ animated: Bool) {
    }
    
}

// MARK: - CLLocationManagerDelegate
//

extension MapLayoutManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        viewController.avoMapView.isMyLocationEnabled = true
        viewController.avoMapView.settings.myLocationButton = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        viewController.avoMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}
// MARK: -
// MARK: - Server

extension MapLayoutManager {
    
    func getShops() {
        viewController.getShopsRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Error")
            } else if let response = response {
                print("RESPONSE", response)
            }
        }
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension MapLayoutManager {
    
    func configure() {
        configureMapDelegate()
        configureSaveButton()
        getServerData()
    }
    
    func configureMapDelegate() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureSaveButton() {
        viewController.saveButton.layer.cornerRadius = 30
        viewController.saveButton.setupShadow(color: AppColor.black(alpha: 0.3))
    }
    
    func getServerData() {
        getShops()
    }
}
