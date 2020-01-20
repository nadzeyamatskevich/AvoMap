//
//  ListOfPlacesTableViewCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/30/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class ListOfPlacesTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var fruilImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func set(shop: ShopModel) {
        shopNameLabel.text = shop.name
        shopAddressLabel.text = shop.address
        switch shop.type {
            case "store":                    fruilImageView.image = #imageLiteral(resourceName: "avoFruit")
            case "food_establishment":       fruilImageView.image = #imageLiteral(resourceName: "foodPin")
            case "store_mango":              fruilImageView.image = #imageLiteral(resourceName: "mango")
            case "food_establishment_mango": fruilImageView.image = #imageLiteral(resourceName: "mango")
            default: print()
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension ListOfPlacesTableViewCell {
    
    func configure() {
        configureMainView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupOnlyBottomShadow(color: AppColor.black(alpha: 0.1))
    }
    
}
