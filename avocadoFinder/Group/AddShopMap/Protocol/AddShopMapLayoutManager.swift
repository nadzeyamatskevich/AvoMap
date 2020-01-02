//
//  AddShopMapLayoutManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/2/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AddShopMapLayoutManager: NSObject {
    
    // - UI
    private unowned let viewController: AddShopMapViewController
    
    // - Data
    private var selectedMarker: GMSMarker?
    var shops: [ShopModel] = []
    
    // - Manager
    var clusterManager: GMUClusterManager!
    private var locationManager = CLLocationManager()
    
    init(viewController: AddShopMapViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
}

// MARK: -
// MARK: - Action

extension AddShopMapLayoutManager {
    
    func myLocationButtonAction() {
        guard let lat = viewController.avoMapView.myLocation?.coordinate.latitude,
              let lng = viewController.avoMapView.myLocation?.coordinate.longitude else { return }

        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 12)
        viewController.avoMapView.animate(to: camera)
    }
    
    func searchButtonAction() {
        UINavigationBar.appearance().tintColor = AppColor.white()
        UINavigationBar.appearance().barTintColor = AppColor.green
        let acController = GMSAutocompleteViewController()
        acController.delegate = viewController
        viewController.present(acController, animated: true, completion: nil)
    }
    
    func didAutocomplete(_ viewController: GMSAutocompleteViewController, place: GMSPlace) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(place.coordinate) { [weak self] (response, error) in
            self?.viewController.address = response?.firstResult()
            self?.viewController.addressString = place.formattedAddress
        }
        let position = GMSCameraUpdate.setTarget(place.coordinate, zoom: 15)
        self.viewController.avoMapView.animate(with: position)
        self.viewController.changeAddress = false
        self.viewController.dismiss(animated: true, completion: { [weak self] in
            if let name = place.name {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: { [weak self] in
                    self?.viewController.addressLabel.text = "\(name)"
                })
            }
            
        })
    }
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] (response, error) in
            if self?.viewController.changeAddress == false { self?.viewController.changeAddress = true; return }
            self?.viewController.address = response?.firstResult()
            guard let lines = self?.viewController.address?.lines else { return }
            let arr = lines.first!.components(separatedBy: ", ")
            self?.viewController.addressLabel.text = "\(arr[0])"
            self?.viewController.addressString = lines.first
            UIView.animate(withDuration: 0.25) {
                self?.viewController.view.layoutIfNeeded()
            }
      }
    }
    
}

// MARK: -
// MARK: - Configure

extension AddShopMapLayoutManager {
    
    func configure() {
        
    }
    
}
