//
//  UIViewControllerExtention.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/25/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import HPGradientLoading

extension UIViewController {
    
    func show(error: String, completion: (() -> Void)? = nil) {
        self.showAlert(title: "Ошибка", message: error, completion: completion)
    }
    
    func showAlert(title: String, message: String, buttonText: String = "OK", completion: (() -> Void)? = nil) {
        let avoPopupViewController = UIStoryboard(storyboard: .avoPopup).instantiateInitialViewController() as! AvoPopupViewController
        avoPopupViewController.modalPresentationStyle = .overFullScreen
        avoPopupViewController.set(title: title, subtitle: message, buttonText: buttonText)
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

    func configureLoader() {
        HPGradientLoading.shared.configation.isEnableDismissWhenTap = false
        HPGradientLoading.shared.configation.isBlurBackground = true
        HPGradientLoading.shared.configation.durationAnimation = 1.0
        HPGradientLoading.shared.configation.fontTitleLoading = UIFont.systemFont(ofSize: 20)
        HPGradientLoading.shared.configation.fromColor = AppColor.darkCyan
        HPGradientLoading.shared.configation.toColor = AppColor.green
        HPGradientLoading.shared.configation.blurColorTintActivity = .clear
    }
}
