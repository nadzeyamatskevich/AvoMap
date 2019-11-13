//
//  AddShopMapViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 10/28/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GoogleMaps

protocol AddShopMapDelegate: class {
    func didAddLocation(latitude: Double, longitude: Double)
}

class AddShopMapViewController: UIViewController {

    // - UI
    @IBOutlet weak var avoMapView: GMSMapView!
    @IBOutlet weak var saveButton: UIButton!
    
    // - Delegate
    weak var delegate: AddShopMapDelegate?
    private var locationManager = CLLocationManager()
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSaveButton()
        configureMapDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 16
        saveButton.setupShadow(color: AppColor.black(alpha: 0.1))
    }

    func configureMapDelegate() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
// MARK: - Navigation

extension AddShopMapViewController {
    
    @IBAction func addNewPlaceButtonAction(_ sender: Any) {
        delegate?.didAddLocation(latitude: avoMapView.projection.coordinate(for: avoMapView.center).latitude, longitude: avoMapView.projection.coordinate(for: avoMapView.center).longitude)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
