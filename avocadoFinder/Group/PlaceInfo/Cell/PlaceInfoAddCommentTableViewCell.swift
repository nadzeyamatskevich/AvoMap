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
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    // - Delegate
    var delegate: PlaceInfoDataSourceDelegate?
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func set(shop: ShopModel) {
        let isMango = shop.type == PlaceType.store_mango.rawValue || shop.type == PlaceType.food_establishment_mango.rawValue
        mainView.backgroundColor = !isMango ? AppColor.avo : AppColor.orange
    }
    
}

// MARK: -
// MARK: - Action

extension PlaceInfoAddCommentTableViewCell {
    
    @IBAction func addCommentButtonAction(_ sender: Any) {
        if checkComment() {
            delegate?.addCommentAction(comment: createComment())
            self.authorTextField.text = ""
            self.commentTextField.text = ""
        }
    }
    
}


// MARK: -
// MARK: - Delegate

extension PlaceInfoAddCommentTableViewCell {
    
    func checkComment() -> Bool {
        if authorTextField.text == "" {
            delegate?.showErrorAlert(message: "Напишите свое имя :)")
        } else if commentTextField.text == "" {
            delegate?.showErrorAlert(message: "Напишите комментарий :)")
        } else {
            return true
        }
        return false
    }
    
    func createComment() -> CommentModel {
        let newComment = CommentModel()
        newComment.author = authorTextField.text!
        newComment.body = commentTextField.text!
        return newComment
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
        self.authorTextField.text = KeychainManager.shared.name
    }
    
}

