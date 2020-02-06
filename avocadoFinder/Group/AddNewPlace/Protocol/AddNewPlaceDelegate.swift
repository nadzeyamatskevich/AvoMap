//
//  AddNewPlaceDelegate.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

protocol AddNewPlaceMainCellDelegate: class {
    func openGoogleAutocompleteVC(_ sender: UITextField)
    func openMap()
}

protocol AddNewPlaceDescriptionCellDelegate: class {
    func openCurrencyVC()
    func changeFruitType(selectedSegment: Int)
}

protocol AddNewPlaceSaveCellDelegate: class {
    func saveNewPlace()
}

protocol AddNewPlaceDelegate: class {}
