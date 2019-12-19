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
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert)
        
        let alerAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default) { _ in
                guard let completion = completion else { return }
                completion()
        }
        
        alert.addAction(alerAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, customActionTitle: String, customActionHandler: @escaping (() -> Void)) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert)
        
        let customAction = UIAlertAction(
            title: customActionTitle,
            style: UIAlertAction.Style.default) { _ in
                customActionHandler()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(customAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
