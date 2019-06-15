//
//  TabBarViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import Device
import RAMAnimatedTabBarController

class TabBarViewController: RAMAnimatedTabBarController {
    
    // - UI
    private var prevIndicatorView: UIView?
    private var indicatorView = UIView()
    private var itemWidth: CGFloat = 0
    
    // - Data
    private var isFirstLayoutSubviews = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        increaseSizeIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLayoutSubviews, let icon = animatedItems[0].iconView {
            isFirstLayoutSubviews = false
            animatedItems[0].iconView?.icon.tintAdjustmentMode = .normal
            animatedItems[0].animation.playAnimation(icon.icon, textLabel: icon.textLabel)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.invalidateIntrinsicContentSize()
        tabBar.superview?.setNeedsLayout()
        tabBar.superview?.layoutSubviews()
    }
    
    func hide(_ needHide: Bool) {
        let alpha: CGFloat = needHide ? 0 : 1
        var index = 0
        
        for item in animatedItems {
            item.iconView?.icon.alpha = alpha
            
            if selectedIndex == index && !needHide {
                item.iconView?.textLabel.alpha = alpha
            } else if needHide {
                item.iconView?.textLabel.alpha = alpha
            }
            index += 1
        }
        
        tabBar.isHidden = needHide
    }
    
    private func increaseSizeIfNeeded() {
        if !view.safeAreaIsSupported() {
            var tabFrame = tabBar.frame
            tabFrame.size.height = Constant.tabBarHeight
            tabFrame.origin.y = self.view.frame.size.height - Constant.tabBarHeight
            tabBar.frame = tabFrame
        }
    }
    
}

// MARK: -
// MARK: - Configure

private extension TabBarViewController {
    
    func configure() {
        configureItemWidth()
        configureAppearance()
        selectedIndex = 0
    }
    
    func configureItemWidth() {
        itemWidth = UIScreen.main.bounds.width / 3
    }
    
    func configureAppearance() {
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.borderWidth = 0.0
        
        tabBar.setupShadow(color: AppColor.black(alpha: 0.1))
        
        for item in animatedItems {
            //item.iconView?.textLabel.font = //AppFont.medium(size: 12)
            item.iconView?.textLabel.alpha = 0
            
            if let icon = item.iconView {
                if let renderImage = icon.icon.image?.withRenderingMode(.alwaysTemplate) {
                    icon.icon.image = renderImage
                    icon.icon.tintColor = AppColor.grayTabBar
                }
            }
            
            (item.animation as! TabBarAnimation).playAnimationClosure = { [weak self] icon, textLabel in
                self?.showIndicatorView(with: icon)
            }
        }
    }
    
    func indexFor(icon: UIImageView) -> Int {
        for index in 0..<animatedItems.count {
            if animatedItems[index].iconView?.icon == icon {
                return index
            }
        }
        return 0
    }
    
}

// MARK: -
// MARK: - Indicator logic

private extension TabBarViewController {
    
    func configureIndicatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        return view
    }
    
    func showIndicatorView(with icon: UIImageView) {
        let index = indexFor(icon: icon)
        let indicator = configureIndicatorView()
        let xOffset = indicatorViewXOffset(for: index)
        indicator.frame = CGRect(x: xOffset, y: 0, width: 70, height: 70)
        prevIndicatorView = indicatorView
        indicatorView = indicator
        hidePrevIndicatorView()
        showWithAnimateIndicatorView()
        tabBar.insertSubview(indicator, at: 0)
    }
    
    func indicatorViewXOffset(for index: Int) -> CGFloat {
        let index = CGFloat(index)
        let xOffset = index * itemWidth
        let marginInCurrentItem = (itemWidth - 70) / 2
        return xOffset + marginInCurrentItem
    }
    
    func showWithAnimateIndicatorView() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.indicatorView.frame.origin.y = -13
            }, completion: nil)
    }
    
    func hidePrevIndicatorView() {
        guard let prevIndicatorView = prevIndicatorView else { return }
        UIView.animate(withDuration: 0.2, animations: {
            prevIndicatorView.frame.origin.y = 0
        }) { _ in
            prevIndicatorView.removeFromSuperview()
        }
    }
    
}

// MARK: -
// MARK: - Const

extension TabBarViewController {
    
    enum Constant {
        static let tabBarHeight: CGFloat = 56.0
    }
    
}
