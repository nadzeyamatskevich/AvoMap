//
//  AddShopMapViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 10/28/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AddShopMapViewController: UIViewController {

    // - UI
    @IBOutlet weak var avoMapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    // - Manager
    private var layoutManager: AddShopMapLayoutManager!
    
    // - Delegate
    weak var delegate: AddShopMapDelegate?
    private var locationManager = CLLocationManager()
    
    // - Data
    var address: GMSAddress?
    var addressString: String?
    var changeAddress = true
    
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

    func configureMapDelegate() {
        avoMapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        layoutManager.reverseGeocodeCoordinate(coordinate)
    }

}

// MARK: -
// MARK: - CLLocationManagerDelegate

extension AddShopMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {return}
        locationManager.startUpdatingLocation()
        self.avoMapView.isMyLocationEnabled = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        self.avoMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
    
}


// MARK: -
// MARK: - Action

extension AddShopMapViewController {
    
    @IBAction func addNewPlaceButtonAction(_ sender: Any) {
        delegate?.didAddLocation(latitude: avoMapView.projection.coordinate(for: avoMapView.center).latitude, longitude: avoMapView.projection.coordinate(for: avoMapView.center).longitude)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        layoutManager.searchButtonAction()
    }
    
    @IBAction func myLocationButtonAction(_ sender: UIButton) {
        layoutManager.myLocationButtonAction()
    }
    
}

// MARK: -
// MARK: - GMSAutocompleteView

extension AddShopMapViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        layoutManager.didAutocomplete(viewController, place: place)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: -
// MARK: - GMSMapViewDelegate

extension AddShopMapViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let position = GMSCameraUpdate.setTarget(coordinate)
        mapView.animate(with: position)
    }
  
}

// MARK: -
// MARK: - Configure

extension AddShopMapViewController {
    
    func configure() {
        configureMapDelegate()
        configureLayoutManager()
    }
    
    func configureLayoutManager() {
        layoutManager = AddShopMapLayoutManager(viewController: self)
    }
    
}
