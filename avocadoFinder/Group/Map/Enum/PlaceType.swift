//
//  PlaceType.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 9/17/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Foundation

enum PlaceType: String {
    case store = "store"
    case store_mango = "store_mango"
    case food_establishment = "food_establishment"
    case food_establishment_mango = "food_establishment_mango"
    
    var isMango: Bool {
        if self == .food_establishment_mango || self == .store_mango {
            return true
        } else {
            return false
        }
    }
}
