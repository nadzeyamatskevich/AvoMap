//
//  MainLayoutManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 12/29/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import MessageUI

class MainLayoutManager: NSObject {
    
    // - Init
    private unowned let vc: MainViewController
    private var childNavigationController: UINavigationController!
    private var mapVC: MapViewController
    private var newsVC: NewsAndBlogViewController
    private var settingsVC: SettingsViewController
    private var screens: [UIViewController]
    
    // - Data
    private var screenWidth = 0
    private var yPosition = 0
    
    // - Lifecycle
    init(viewController: MainViewController) {
        self.vc = viewController
        newsVC = UIStoryboard(storyboard: .newsAndBlog).instantiateInitialViewController() as! NewsAndBlogViewController
        mapVC = UIStoryboard(storyboard: .map).instantiateInitialViewController() as! MapViewController
        settingsVC = UIStoryboard(storyboard: .settings).instantiateInitialViewController() as! SettingsViewController
        screens = [newsVC, mapVC, settingsVC]
        super.init()
        configure()
    }
    
}

// MARK: - Action

extension MainLayoutManager {
    
    
    
}

// MARK: - Update

extension MainLayoutManager {
    
    func viewDidAppear() {
        setupScrollView()
        setupViewContrillersOnScrollView()
        vc.setNeedsStatusBarAppearanceUpdate()
    }
    
    func updateStatusBar(isHidden: Bool, animation: UIStatusBarAnimation) {
        self.vc.statusBarHidden = isHidden
        self.vc.statusBarUpdateAnimation = animation
        self.vc.setNeedsStatusBarAppearanceUpdate()
    }
    
}

// MARK: - Setup

extension MainLayoutManager {
    
    func setupViewContrillersOnScrollView() {
        yPosition = Int(vc.scrollView.contentOffset.y)
        screens.enumerated().forEach {
            vc.addChild($1)
            vc.scrollView.addSubview($1.view)
            $1.willMove(toParent: vc)
            $1.view.frame = vc.containerView.frame
            $1.view.frame.origin = CGPoint(x: Int(vc.containerView.bounds.width) * $0, y: yPosition)
//            setupDelegate(object: $1)
        }
    }
    
    func setupScrollView() {
        screenWidth = Int(UIScreen.main.bounds.width)
        vc.scrollView.isPagingEnabled = true
        vc.scrollView.contentSize = CGSize(width: vc.containerView.bounds.width * 4, height: 1)
        vc.scrollView.showsHorizontalScrollIndicator = false
        vc.scrollView.showsVerticalScrollIndicator = false
        vc.scrollView.bounces = false
    }
    
//    func setupDelegate(object: UIViewController) {
//        if let plan = object as? PlanVC { plan.delegate = vc}
//        if let statistics = object as? StatisticsWithHistoryVC { statistics.delegate = vc}
//        if let profile = object as? ProfileVC { profile.delegate = vc}
//        if let more = object as? MoreVC { more.delegate = vc}
//    }
    
}

// MARK: - Configure

private extension MainLayoutManager {
    
    func configure() {
        setupScrollView()
    }
    
    func initViewControllers() {
        
    }

}
