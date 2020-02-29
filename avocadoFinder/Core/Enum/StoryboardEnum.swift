//
//  StoryboardEnum.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

enum Storyboard: String {
    
    // - Main
    case main = "Main"
    
    // - Main
    case currencies = "Currencies"
    
    // - Recipes
    case recipes = "Recipes"
    case recipeInfo = "RecipeInfo"
    
    // - Tab Bar
    case tabBar = "TabBar"
    
    // - News
    case oneNews = "OneNewsInfo"
    case newsAndBlog = "NewsAndBlog"
    
    // - Map
    case map = "Map"
    case listOfPlaces = "ListOfPlaces"
    case placeInfo = "PlaceInfo"
    case addNewPlace = "AddNewPlace"
    case addShopMap = "AddShopMap"
    
    // - Settings
    case staticPage = "StaticPage"
    case settings = "Settings"
    
    // - Alert
    case avoPopup = "AvoPopup"
    
    var filename: String {
        return rawValue
    }
    
}
