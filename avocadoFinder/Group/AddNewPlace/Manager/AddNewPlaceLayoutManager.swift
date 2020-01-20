//
//  AddNewPlaceLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/14/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AddNewPlaceLayoutManager: NSObject {
    
    // - UI
    private unowned let viewController: AddNewPlaceViewController
    
    init(viewController: AddNewPlaceViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
    func changeNavbar(isAVO: Bool) {
        let image = isAVO ? UIImage(named: "listOfPlacesNavBarBg") : UIImage(named: "orangeNavBar")
        UIView.transition(with: viewController.navBarImageView, duration: 0.5, options: .transitionCrossDissolve, animations: { self.viewController.navBarImageView.image = image }, completion: nil)
    }
    
}

// MARK: -
// MARK: - Configure

extension AddNewPlaceLayoutManager {
    
    func configure() {
        configureKeyboard()
        setNavBar()
    }
    
    func configureKeyboard() {
        viewController.hideKeyboardWhenTappedAround()
    }
    
    func setNavBar() {
        viewController.navBarImageView.image = viewController.type == .avocado ? #imageLiteral(resourceName: "listOfPlacesNavBarBg") : #imageLiteral(resourceName: "orangeNavBar")
    }
    
}
