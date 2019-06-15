//
//  NewsAndBlogCoordinatorManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class NewsAndBlogCoordinatorManager {
    
    // - UI
    private unowned var viewController: NewsAndBlogViewController
    
    init(viewController: NewsAndBlogViewController) {
        self.viewController = viewController
    }
    
    func pushOneNewsInfoViewController() {
        let postViewController = UIStoryboard(storyboard: .oneNews).instantiateInitialViewController() as! OneNewsInfoViewController
        viewController.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
