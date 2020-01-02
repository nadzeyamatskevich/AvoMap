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
    
    func pushOneNewsInfoViewController(news: NewsModel, image: UIImage?) {
        let postViewController = UIStoryboard(storyboard: .oneNews).instantiateInitialViewController() as! OneNewsInfoViewController
        postViewController.news = news
        postViewController.image = image
        viewController.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
