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
import Firebase

class MapLayoutManager: NSObject {
    
    // - UI
    private unowned let viewController: MapViewController
    
    // - Data
    private var selectedMarker: GMSMarker?
    var shops: [ShopModel] = []
    
    // - Manager
    var clusterManager: GMUClusterManager!
    private var locationManager = CLLocationManager()
    private let userDefaultsManager = UserDefaultsManager()
    
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
// MARK: - Action

extension MapLayoutManager {
    
    func myLocationButtonAction() {
        guard let lat = viewController.avoMapView.myLocation?.coordinate.latitude,
              let lng = viewController.avoMapView.myLocation?.coordinate.longitude else { return }

        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 12)
        viewController.avoMapView.animate(to: camera)
    }
    
}

// MARK: -
// MARK: - Animation

extension MapLayoutManager {
    
    func hidePluseButton() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let vc = self?.viewController else { return }
            vc.plusBottomConstraint.constant = -160
            vc.plusRightConstraint.constant = -160
            vc.view.layoutIfNeeded()
        }
    }
    
    func showPluseButton() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let vc = self?.viewController else { return }
            vc.plusBottomConstraint.constant = -80
            vc.plusRightConstraint.constant = -80
            vc.view.layoutIfNeeded()
        }
    }
    
    func makeInactiveSegmentControl() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let vc = self?.viewController else { return }
            vc.contentTypeControl.isUserInteractionEnabled = false
            vc.contentTypeControl.alpha = 0.5
            vc.view.layoutIfNeeded()
        }
    }
    
    func makeActiveSegmentControl() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let vc = self?.viewController else { return }
            vc.contentTypeControl.isUserInteractionEnabled = true
            vc.contentTypeControl.alpha = 1
            vc.view.layoutIfNeeded()
        }
    }
    
}

// MARK: -
// MARK: - GMUClusterManagerDelegate

extension MapLayoutManager {
    
    func listOfPlacesButtonAction() {
        if viewController.isListHidden {
            showList()
            addAnalyticsEventOpenList()
        } else {
            hideList()
            addAnalyticsEventOpenMap()
        }
    }
    
    func addAnalyticsEventOpenMap() {
        Analytics.logEvent("open_map", parameters: [:])
    }
    
    func addAnalyticsEventOpenList() {
        Analytics.logEvent("open_list", parameters: [:])
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
                let item = POIItem(position: CLLocationCoordinate2DMake(Double(lat)!, Double(lng)!), shopId: shopId, iconView: iconImageView, shopType: shopType)//, price: shop.price)
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
        viewController.avoMapView.settings.myLocationButton = false
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
        viewController.getShopsRequest() { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                self?.viewController.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if let response = response {
                strongSelf.shops = response
                strongSelf.viewController.shops = response
                strongSelf.updateMapViewData()
            }
        }
    }
    
    func updateMapViewData() {
        switch viewController.type {
        case .avocado:
            switch viewController.contentTypeControl.selectedSegmentIndex {
            case 0:
                self.shops = viewController.shops.filter {$0.type == "store"}
                addAnalyticsEventOpenShops()
                showPluseButton()
            default:
                self.shops = viewController.shops.filter {$0.type == "food_establishment"}
                addAnalyticsEventOpenCafe()
                hidePluseButton()
            }
        case .mango:
            switch viewController.contentTypeControl.selectedSegmentIndex {
            case 0:
                self.shops = viewController.shops.filter {$0.type == "store_mango"}
                addAnalyticsEventOpenShops()
                showPluseButton()
            default:
                self.shops = viewController.shops.filter {$0.type == "food_establishment_mango"}
                addAnalyticsEventOpenCafe()
                hidePluseButton()
            }
        }
        self.update()
    }
    
    func changeStyle(type: TypeOfFruit) {
        let image = type == .avocado ? UIImage(named: "navBarBg") : UIImage(named: "mangoNavBar")
        let typeControl = viewController.typeControl
        let contentTypeControl = viewController.contentTypeControl
        UIView.transition(with: viewController.navBarBgImageView, duration: 0.5, options: .transitionCrossDissolve, animations: { self.viewController.navBarBgImageView.image = image }, completion: nil)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewController.plusView.backgroundColor = type == .avocado ? AppColor.avo : AppColor.orange
            self?.viewController.myPosition.backgroundColor = type == .avocado ? AppColor.avo : AppColor.orange
            typeControl?.backgroundColor = type == .avocado ? AppColor.avo60 : AppColor.orange60
            contentTypeControl?.backgroundColor = type == .avocado ? AppColor.avo60 : AppColor.orange60
        }
        UIView.transition(with: typeControl!, duration: 0.5, options: [.beginFromCurrentState , .transitionCrossDissolve], animations: { () -> Void in
            if #available(iOS 13.0, *) {
                typeControl?.selectedSegmentTintColor = type == .avocado ? AppColor.avo : AppColor.orange
            } else {
                typeControl?.tintColor = type == .avocado ? AppColor.avo : AppColor.orange
            }
        }, completion: nil)
        UIView.transition(with: contentTypeControl!, duration: 0.5, options: [.beginFromCurrentState , .transitionCrossDissolve], animations: { () -> Void in
            if #available(iOS 13.0, *) {
                contentTypeControl?.selectedSegmentTintColor = type == .avocado ? AppColor.avo : AppColor.orange
            } else {
                contentTypeControl?.tintColor = type == .avocado ? AppColor.avo : AppColor.orange
            }
        }, completion: nil)
    }
    
    func addAnalyticsEventOpenShops() {
        Analytics.logEvent("open_shops", parameters: [:])
    }
    
    func addAnalyticsEventOpenCafe() {
        Analytics.logEvent("open_cafe", parameters: [:])
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
        viewController.openPlaceList(shops: shopArr, isHideControl: true)
        makeInactiveSegmentControl()
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
//            if viewController.type == .avocado{
//                marker.icon = shop.shopType == "store" ? UIImage(named: "shopPin") : UIImage(named: "foodPin")
//            } else {
//                marker.icon = shop.shopType == "store" ? UIImage(named: "shopPin") : UIImage(named: "foodPin")
//            }
//
//            switch shop.shopType {
//                case "store": marker.icon = UIImage(named: "mango")
//                case "food_establishment": marker.icon = UIImage(named: "mango")
//                case "store_mango": marker.icon = UIImage(named: "foodPin")
//                case "food_establishment_mango": marker.icon = UIImage(named: "shopPin")
//                default: marker.icon = UIImage(named: "foodPin")
//            }
            setIconForMarker(willRenderMarker: marker,shopType:shop.shopType)
            //marker.icon = shop.shopType == "store" ? generateAvoPinWithPrice(text: shop.price) : UIImage(named: "foodPin")
        } else {
            marker.icon = UIImage(named: "shopPin")
        }
    }
    
    func setIconForMarker(willRenderMarker marker: GMSMarker, shopType: String) {
        switch shopType {
            case "store": marker.icon = UIImage(named: "shopPin")
            case "food_establishment": marker.icon = UIImage(named: "foodPin")
            case "store_mango": marker.icon = UIImage(named: "foodPin")
            case "food_establishment_mango": marker.icon = UIImage(named: "mango")
            default: marker.icon = UIImage(named: "mango")
        }
    }
    
    func getIcon() -> UIImage? {
        switch viewController.type {
        case .avocado:
            switch viewController.contentTypeControl.selectedSegmentIndex {
                case 0:  return UIImage(named: "shopPin")
                default: return UIImage(named: "foodPin")
            }
        case .mango:
            switch viewController.contentTypeControl.selectedSegmentIndex {
                case 0:  return UIImage(named: "mango")
                default: return UIImage(named: "mango")
            }
        }
    }
    
    func generateImageWithText(text: String) -> UIImage {
        let state = viewController.contentTypeControl.selectedSegmentIndex
        let image = getIcon() ?? UIImage()
        let imageView = UIImageView(image: getIcon())
        imageView.backgroundColor = .clear
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height - 20))
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = state == 0 ? .white : AppColor.darkGreen
        label.text = text
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithText!
    }
    
    func generateAvoPinWithPrice(text: String) -> UIImage {
        let image = UIImage(named: "avoPin")!
        
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = .clear
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let label = UILabel(frame: CGRect(x: 0, y: image.size.width/3, width: image.size.width, height: image.size.height/4))
        label.backgroundColor = .red
        label.textAlignment = .center
        label.textColor = .white
        label.text = text
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithText!
    }
    
}


// MARK: -
// MARK: - Setup

extension MapLayoutManager {
    
    func setupSegmentControlWidth() {
        var attributes: [NSAttributedString.Key : NSObject] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.white
        switch UIScreen.main.bounds.height {
            case ...568:
                viewController.segmentControlWidthConstraint.constant = 180
                attributes[NSAttributedString.Key.font] = AppFont.bold(size:15)
            case 667...736:
                viewController.segmentControlWidthConstraint.constant = 200
                attributes[NSAttributedString.Key.font] = AppFont.bold(size:16)
            default:
                viewController.segmentControlWidthConstraint.constant = 235
                attributes[NSAttributedString.Key.font] = AppFont.bold(size:18)
        }
        viewController.contentTypeControl.setTitleTextAttributes(attributes, for: .normal)
        viewController.contentTypeControl.setTitleTextAttributes(attributes, for: .selected)
    }
    
    func hideList() {
        viewController.isListHidden = true
        viewController.listButton.setImage(UIImage(named: "list"), for: .normal)
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let сonstraint =  self?.viewController.listTopConstraint else { return }
            сonstraint.constant += UIScreen.main.bounds.height
            self?.viewController.view.layoutIfNeeded()
        },completion: { [weak self] _ in
            self?.viewController.view.isUserInteractionEnabled = true
            self?.makeActiveSegmentControl()
        })
    }
    
    func showList() {
        viewController.isListHidden = false
        viewController.listButton.setImage(UIImage(named: "global"), for: .normal)
        viewController.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let сonstraint =  self?.viewController.listTopConstraint else { return }
            сonstraint.constant -= UIScreen.main.bounds.height
            self?.viewController.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.viewController.view.isUserInteractionEnabled = true
        })
    }
    
    func viewWillAppear() {
        getShops()
        setupSegmentControlWidth()
    }
}

// MARK: -
// MARK: - Configure

fileprivate extension MapLayoutManager {
    
    func configure() {
        initializeClusterItems()
        configureMapDelegate()
        getShops()
        configureType()
        DispatchQueue.main.async { [weak self] in
            self?.hideList()
        }
    }
    
    func configureType() {
        let type = userDefaultsManager.get(data: .type)
        viewController.type = type == "\(TypeOfFruit.mango)" ? .mango : .avocado
        viewController.typeControl.selectedSegmentIndex = type == "\(TypeOfFruit.mango)" ? 1 : 0
    }
    
    func configureMapDelegate() {
        viewController.avoMapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureShopsMarkers() {
        viewController.updateTableViewData()
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
