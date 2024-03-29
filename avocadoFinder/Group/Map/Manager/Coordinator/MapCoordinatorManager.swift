//
//  MapCoordinatorManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class MapCoordinatorManager {
    
    // - UI
    private unowned var viewController: MapViewController
    
    init(viewController: MapViewController) {
        self.viewController = viewController
    }
    
    func pushLitsOfPlacesViewController(shops: [ShopModel], switchState: Int, isHideControl: Bool = false) {
//        let listOfPlacesViewController = UIStoryboard(storyboard: .listOfPlaces).instantiateInitialViewController() as! ListOfPlacesViewController
//        listOfPlacesViewController.shops = shops
//        listOfPlacesViewController.switchState = switchState
//        listOfPlacesViewController.isHideControl = isHideControl
//        viewController.navigationController?.pushViewController(listOfPlacesViewController, animated: true)
    }
    
    func pushAddNewPlaceViewController() {
        let addNewPlaceViewController = UIStoryboard(storyboard: .addNewPlace).instantiateInitialViewController() as! AddNewPlaceViewController
        addNewPlaceViewController.type = viewController.type
        addNewPlaceViewController.delegate = viewController
        viewController.navigationController?.pushViewController(addNewPlaceViewController, animated: true)
    }
    
    func pushPlaceViewController(shop: ShopModel) {
        let placeViewController = UIStoryboard(storyboard: .placeInfo).instantiateInitialViewController() as! PlaceInfoViewController
        placeViewController.shop = shop
        viewController.navigationController?.pushViewController(placeViewController, animated: true)
    }
    
}
