//
//  CurrencyTableViewCell.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var selectedIconConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(currency: CurrencyModel, selectedСurrency: String) {
        nameLabel.text = "\(currency.name)"
        currencyLabel.text = currency.currency
        selectedIconConstraint.constant = selectedСurrency == currency.currency ? 16 : 0
        nameLabel.textColor = selectedСurrency == currency.currency ? AppColor.selected : AppColor.darkBlack
    }
    
}
