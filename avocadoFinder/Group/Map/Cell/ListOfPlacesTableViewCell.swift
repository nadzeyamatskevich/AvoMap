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
        case PlaceType.store.rawValue: fruilImageView.image = shop.ripe ?
            #imageLiteral(resourceName: "shopPin").sd_rotatedImage(withAngle: .pi, fitSize: false) : #imageLiteral(resourceName: "badAvocado").sd_rotatedImage(withAngle: .pi, fitSize: false)
            
        case PlaceType.food_establishment.rawValue:       fruilImageView.image = #imageLiteral(resourceName: "foodPin")
            
        case PlaceType.store_mango.rawValue: fruilImageView.image = shop.ripe ? #imageLiteral(resourceName: "mango") : #imageLiteral(resourceName: "badMango")
            
        case PlaceType.food_establishment_mango.rawValue: fruilImageView.image = #imageLiteral(resourceName: "mango")
            
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
