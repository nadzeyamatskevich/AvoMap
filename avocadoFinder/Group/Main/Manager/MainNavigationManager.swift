//
//  MainNavigationManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 12/31/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class MainNavigationManager: NSObject {
    
    // - Init
    private unowned let vc: MainViewController
    
    // - Lifecycle
    init(viewController: MainViewController) {
        self.vc = viewController
        super.init()
        configure()
    }
    
}

// MARK: - Navigation

extension MainNavigationManager {
    
    
}

// MARK: - Configure

private extension MainNavigationManager {
    
    func configure() {
        
    }

}
