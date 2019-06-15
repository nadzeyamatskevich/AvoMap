//
//  TabBarAnimation.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class TabBarAnimation: RAMItemAnimation {
    
    var playAnimationClosure: ((UIImageView, UILabel) -> Void)?
    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        if let playAnimationClosure = self.playAnimationClosure {
            playAnimationClosure(icon, textLabel)
        }
        
        select(true, icon: icon, textLabel: textLabel)
        animate(select: true, textLabel: textLabel)
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        select(false, icon: icon, textLabel: textLabel)
        animate(select: false, textLabel: textLabel)
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {}
    
    func select(_ isSelected: Bool, icon: UIImageView, textLabel: UILabel) {
        let color = isSelected ? AppColor.cyan : AppColor.grayTabBar
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysTemplate)
            icon.image = renderImage
            icon.tintColor = color
        }
        
        textLabel.textColor = color
    }
    
}

// MARK: -
// MARK: - Animation logic

extension TabBarAnimation {
    
    func animate(select: Bool, textLabel: UILabel) {
        //let textAlpha: CGFloat = select ? 1 : 0
        let textYOffset: CGFloat = select ? 5 : 16
        let iconYOffset: CGFloat = select ? -17 : -5
        
        textLabel.superview?.centerYConstaint?.constant = iconYOffset
        textLabel.findConstraint(layoutAttribute: .centerY)?.constant = textYOffset
        
        UIView.animate(withDuration: 0.2) {
            textLabel.superview?.layoutIfNeeded()
            //textLabel.alpha = textAlpha
        }
    }
    
}
