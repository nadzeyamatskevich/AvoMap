//
//  AddNewPlaceMainTableViewCell.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AddNewPlaceMainTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var shopAddressTextField: UITextField!
    @IBOutlet weak var shopAuthorTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureMainView()
    }
    
    func setAddress(_ address: String) {
        shopAddressTextField.text = address
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupOnlyBottomShadow(color: AppColor.black(alpha: 0.1))
    }

}
