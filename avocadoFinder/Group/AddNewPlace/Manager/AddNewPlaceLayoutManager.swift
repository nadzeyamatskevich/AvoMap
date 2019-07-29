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
    
}

// MARK: -
// MARK: - Configure

extension AddNewPlaceLayoutManager {
    
    func configure() {
        configureKeyboard()
        configureMainView()
        configureSaveButton()
    }
    
    func configureKeyboard() {
        viewController.hideKeyboardWhenTappedAround()
    }
    
    func configureMainView() {
        viewController.mainView.layer.cornerRadius = 16
        viewController.mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
    func configureSaveButton() {
        viewController.saveButton.layer.cornerRadius = 16
        viewController.saveButton.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
}