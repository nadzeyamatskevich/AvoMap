//
//  StoryboardEnum.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

enum Storyboard: String {
    
    // - Tab Bar
    case tabBar = "TabBar"
    
    // - News
    case oneNews = "OneNewsInfo"
    
    // - Map
    case listOfPlaces = "ListOfPlaces"
    case placeInfo = "PlaceInfo"
    case addNewPlace = "AddNewPlace"
    case addShopMap = "AddShopMap"
    
    // - Settings
    case staticPage = "StaticPage"
    
    // - Alert
    case avoPopup = "AvoPopup"
    
    var filename: String {
        return rawValue
    }
    
}
