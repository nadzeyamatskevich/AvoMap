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
    
}

// MARK: -
// MARK: - Action

extension PlaceInfoAddCommentTableViewCell {
    
    @IBAction func addCommentButtonAction(_ sender: Any) {
        if checkComment() {
            delegate?.addCommentAction(comment: createComment())
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
    }
    
}

