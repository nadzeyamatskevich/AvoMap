//
//  LocationManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/27/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import CoreLocation
import Foundation

typealias UserLocation = ((_ location: CLLocation?) -> Void)

protocol LocationManagerDelegate: class {
    func locationInvalid(status: CLAuthorizationStatus)
    func fail(with error: Error)
}

class LocationManager: NSObject {
    
    private var locationManager = CLLocationManager()
    private var locationClosure: UserLocation?
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - Private

extension LocationManager {
    
    class func isLocationDisableForMyAppOnly() -> Bool {
        
        if !CLLocationManager.locationServicesEnabled() {
            return true
        }
        
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .notDetermined {
            return true
        }
        
        return false
    }
}

// MARK: - Public

extension LocationManager {
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getUserLocation(completion: @escaping UserLocation) {
        
        self.locationClosure = completion
        
        let locationDisabled = LocationManager.isLocationDisableForMyAppOnly()
        if locationDisabled {
            requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        
        if let closure = self.locationClosure {
            closure(locationManager.location)
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedAlways || status == .authorizedWhenInUse else {
            delegate?.locationInvalid(status: status)
            return
        }
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.fail(with: error)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, let locationClosure = self.locationClosure {
            locationClosure(location)
        }
    }
}
