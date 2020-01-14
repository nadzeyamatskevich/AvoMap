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
    fileprivate unowned let viewController: AddNewPlaceViewController
    
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
    }
    
    func configureKeyboard() {
        viewController.hideKeyboardWhenTappedAround()
    }
    
//    func configureNavigationBar() {
//        switch UIScreen.main.bounds.height {
//            case ...568:    viewController.navigationBarHeightConstraint.constant = 150
//            case 667...736: viewController.navigationBarHeightConstraint.constant = 176
//            default:        viewController.navigationBarHeightConstraint.constant = 186
//        }
//    }
    
}
