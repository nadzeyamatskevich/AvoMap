//
//  MapLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import HPGradientLoading

class MapLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: MapViewController
    
    // - Data
    private var selectedMarker: GMSMarker?
    var shops: [ShopModel] = []
    
    // - Manager
    var clusterManager: GMUClusterManager!
    private var locationManager = CLLocationManager()
    
    init(viewController: MapViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
    func update() {
        configureShopsMarkers()
    }
    
}

// MARK: -
// MARK: - GMUClusterManagerDelegate

extension MapLayoutManager: GMUClusterManagerDelegate {
    
    func initializeClusterItems() {
        let iconGenerator = IconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = ClusterRender(mapView: viewController.avoMapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: viewController.avoMapView, algorithm: algorithm, renderer: renderer)
        
        generateClusterItems()
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    private func generateClusterItems() {
        clusterManager.clearItems()
        for shop in shops {
            let lat = shop.latitude
            let lng = shop.longitude
            let shopId = "\(shop.id)"
            let shopType = shop.type
            let iconImageView = shop.type == "store" ?
            UIImageView(image: UIImage(named: "shopPin")) :
            UIImageView(image: UIImage(named: "foodPin"))
            if Double(lat)! > -85.0 && Double(lat)! < 85.0 && Double(lng)! > -180.0 && Double(lng)! < 180.0 {
                let item = POIItem(position: CLLocationCoordinate2DMake(Double(lat)!, Double(lng)!), shopId: shopId, iconView: iconImageView, shopType: shopType)
                clusterManager.add(item)
            }            
        }
        clusterManager.cluster()
    }
    
}

// MARK: -
// MARK: - CLLocationManagerDelegate

extension MapLayoutManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {return}
        locationManager.startUpdatingLocation()
        viewController.avoMapView.isMyLocationEnabled = true
        viewController.avoMapView.settings.myLocationButton = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        viewController.avoMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
    
}

// MARK: -
// MARK: - Server

extension MapLayoutManager {
    
    func getShops() {
        HPGradientLoading.shared.showLoading()
        viewController.getShopsRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                HPGradientLoading.shared.dismiss()
                self?.viewController.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if let response = response {
                strongSelf.shops = response
                strongSelf.viewController.shops = response
                strongSelf.updateMapViewData()
                HPGradientLoading.shared.dismiss()
            }
        }
    }
    
    func updateMapViewData() {
        switch viewController.contentTypeControl.selectedSegmentIndex {
        case 0:
            self.viewController.saveButton.isHidden = false
            self.shops = viewController.shops.filter {$0.type == "store"}
        default:
            self.viewController.saveButton.isHidden = true
            self.shops = viewController.shops.filter {$0.type == "food_establishment"}
        }
        self.update()
    }
    
}


// MARK: -
// MARK: - Helpers

private extension MapLayoutManager {
    
    func getDefaultLocation() -> CLLocationCoordinate2D {
        let defaultLocation = CLLocationCoordinate2D(latitude: 53.904456, longitude: 27.561590)
        return defaultLocation
    }
    
    func selectShopMarker(marker: GMSMarker) {
        if let poiitem = marker.userData as? POIItem {
            guard let markerImageView = poiitem.iconView else { return }
            selectedMarker = marker
            
            let animationCompletion:(Bool) -> Void = { [weak self] finished in
                guard let strongSelf = self else { return }
                if let shopId = poiitem.shopId {
                    let shop = strongSelf.shops.filter { $0.id == shopId }.first ?? ShopModel()
                    strongSelf.viewController.openPlaceInfo(shop: shop)
                }
            }
            UIView.transition(with: markerImageView, duration: 0.35, options: [.transitionFlipFromRight], animations: nil, completion: animationCompletion)
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension MapLayoutManager: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let cluster = marker.userData as? GMUCluster {
            generateShopsArray(cluster: cluster)
        } else if (marker.userData as? POIItem) != nil {
            selectShopMarker(marker: marker)
            return selectedMarker == nil
        }
        return false
    }
    
    func generateShopsArray(cluster: GMUCluster) {
        var shopArr: [ShopModel] = []
        for item in cluster.items {
            if let i  = item as? POIItem {
                shopArr.append(shops.filter{ $0.id == i.shopId }.first!)                
            }
        }
        viewController.openPlaceList(shops: shopArr)
    }
}

// MARK: -
// MARK: - GMUClusterRendererDelegate

extension MapLayoutManager: GMUClusterRendererDelegate {
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        if marker.userData is GMUStaticCluster {
            let clusterMarker = marker.userData as! GMUStaticCluster
            marker.icon = generateImageWithText(text: "\(clusterMarker.count)")
        } else if let shop = marker.userData as? POIItem {

            marker.icon = shop.shopType == "store" ? UIImage(named: "shopPin") : UIImage(named: "foodPin")
        } else {
            marker.icon = UIImage(named: "shopPin")
        }
    }
    
    func generateImageWithText(text: String) -> UIImage {
        let image = UIImage(named: "shopPin")!
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = .clear
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width - 10, height: image.size.height - 10)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width - 8, height: image.size.height - 30))
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        label.text = text
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension MapLayoutManager {
    
    func configure() {
        initializeClusterItems()
        configureSaveButton()
        configureMapDelegate()
        getShops()
        viewController.configureLoader()
    }
    
    func configureSaveButton() {
        viewController.saveButton.layer.cornerRadius = 30
        viewController.saveButton.setupShadow(color: AppColor.black(alpha: 0.2))
    }
    
    func configureMapDelegate() {
        viewController.avoMapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureShopsMarkers() {
        viewController.avoMapView.clear()
        generateClusterItems()
    }
    
    func placeShopMarker(shop: ShopModel) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 42, height: 51))
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .clear
            shop.type == PlaceType.store.rawValue ? (imageView.image = #imageLiteral(resourceName: "shopPin")) : (imageView.image = #imageLiteral(resourceName: "foodPin"))
            
            let marker = GMSMarker()
            marker.iconView = imageView
            marker.position = CLLocationCoordinate2D(latitude: Double(shop.latitude)!, longitude: Double(shop.longitude)!)
            marker.map = strongSelf.viewController.avoMapView
            marker.userData = ["shopId": shop.id]
        }
    }
    
}
