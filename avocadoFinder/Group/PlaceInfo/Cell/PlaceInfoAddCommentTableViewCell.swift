//
//  PlaceInfoAddCommentTableViewCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class PlaceInfoAddCommentTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var mainView: UIView!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    // - Action
    @IBAction func addCommentButtonAction(_ sender: Any){
    }
    
}

// MARK: -
// MARK: - Configure

extension PlaceInfoAddCommentTableViewCell {
    
    func configure() {
        configureMainView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
}

