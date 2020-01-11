//
//  AddShopMapDelegate.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/2/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import Foundation

protocol AddShopMapDelegate: class {
    func didAddLocation(latitude: Double, longitude: Double)
}
