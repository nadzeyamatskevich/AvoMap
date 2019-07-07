//
//  PlaceInfoLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/7/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class PlaceInfoLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: PlaceInfoViewController
    
    init(viewController: PlaceInfoViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
}

// -
// MARK: - Configure

extension PlaceInfoLayoutManager {
    
    func configure() {
        configureKeyboard()
    }
    
    func configureKeyboard() {
        viewController.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: -
// MARK: - Notifications

extension PlaceInfoLayoutManager {
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            viewController.tableVIew.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            viewController.tableVIew.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
}

