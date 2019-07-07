//
//  PlaceInfoDataSourceDelegate.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/7/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

protocol PlaceInfoDataSourceDelegate: class {
    func addCommentAction(comment: CommentModel)
    func showErrorAlert(message: String)
}
