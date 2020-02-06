//
//  AddNewPlaceDescriptionTableViewCell.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AddNewPlaceDescriptionTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet var degreeOfRipenessImageViewCollection: [UIImageView]!
    @IBOutlet weak var degreeOfRipenessSegmentedControl: UISegmentedControl!
    @IBOutlet weak var productSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!
    
    var delegate: AddNewPlaceDescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureMainView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupOnlyBottomShadow(color: AppColor.black(alpha: 0.1))
    }
    
    @IBAction func currencyButtonAction(_ sender: Any) {
        self.delegate?.openCurrencyVC()
    }

    @IBAction func changeFruitTypeSegmentControlAction(_ sender: UISegmentedControl) {
        self.delegate?.changeFruitType(selectedSegment: sender.selectedSegmentIndex)
    }

    func changeType(isAVO: Bool) {
        if #available(iOS 13.0, *) {
            productSegmentedControl.selectedSegmentTintColor = isAVO ? AppColor.avo : AppColor.orange
            degreeOfRipenessSegmentedControl.selectedSegmentTintColor = isAVO ? AppColor.avo : AppColor.orange
        } else {
            productSegmentedControl.tintColor = isAVO ? AppColor.avo : AppColor.orange
            degreeOfRipenessSegmentedControl.tintColor = isAVO ? AppColor.avo : AppColor.orange
        }
        let badImage = isAVO ? UIImage(named: "badAvocado") : UIImage(named: "badMango")
        let image = isAVO ? UIImage(named: "shopPin") : UIImage(named: "mango")
        UIView.transition(with: degreeOfRipenessImageViewCollection[1], duration: 0.5, options: .transitionCrossDissolve, animations: { self.degreeOfRipenessImageViewCollection[1].image = badImage }, completion: nil)
        UIView.transition(with: degreeOfRipenessImageViewCollection[0], duration: 0.5, options: .transitionCrossDissolve, animations: { self.degreeOfRipenessImageViewCollection[0].image = image }, completion: nil)
    }
    
    func setType(type: TypeOfFruit) {
        let isAVO = type == .avocado
        if #available(iOS 13.0, *) {
            productSegmentedControl.selectedSegmentTintColor = isAVO ? AppColor.avo : AppColor.orange
            degreeOfRipenessSegmentedControl.selectedSegmentTintColor = isAVO ? AppColor.avo : AppColor.orange
        } else {
            productSegmentedControl.tintColor = isAVO ? AppColor.avo : AppColor.orange
            degreeOfRipenessSegmentedControl.tintColor = isAVO ? AppColor.avo : AppColor.orange
        }
        productSegmentedControl.selectedSegmentIndex = isAVO ? 0 : 1
        let badImage = isAVO ? UIImage(named: "badAvocado") : UIImage(named: "badMango")
        let image = isAVO ? UIImage(named: "shopPin") : UIImage(named: "mango")
        self.degreeOfRipenessImageViewCollection[1].image = badImage
        self.degreeOfRipenessImageViewCollection[0].image = image
    }

}
