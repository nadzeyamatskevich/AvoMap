//
//  TermsInfoSettingsCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/13/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class TermsInfoSettingsCell: UITableViewCell {

    // - UI
    @IBOutlet weak var titleLabel: UILabel!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(value: String) {
        titleLabel.text = value
    }

}
