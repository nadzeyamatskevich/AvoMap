//
//  UIViewControllerExtention.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/25/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func show(error: String, completion: (() -> Void)? = nil) {
        self.showAlert(title: "Ошибка", message: error, completion: completion)
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let avoPopupViewController = UIStoryboard(storyboard: .avoPopup).instantiateInitialViewController() as! AvoPopupViewController
        avoPopupViewController.modalPresentationStyle = .overFullScreen
        avoPopupViewController.set(title: title, subtitle: message, buttonText: "OK")
        avoPopupViewController.alertButtonHandler = completion
        self.present(avoPopupViewController, animated: false, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
