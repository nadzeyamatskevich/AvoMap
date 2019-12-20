//
//  NewsAndBlogDataSourceDelegate.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

protocol NewsAndBlogDataSourceDelegate: class {
    func didTapOnCell(news: NewsModel)
}
