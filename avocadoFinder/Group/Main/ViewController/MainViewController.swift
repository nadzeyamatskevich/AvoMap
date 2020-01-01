//
//  MainViewController.swift
//  avocadoFinder
//
//  Created by Nick Poe on 12/29/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // - UI
    @IBOutlet var tapButtonConstraintsCollection: [NSLayoutConstraint]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var tapBarButtonsCollection: [UIButton]!
    @IBOutlet var tapBarImageViewCollection: [UIImageView]!
    @IBOutlet weak var tapBarView: UIView!
    
    // - Managers/Serivces
    private var layoutManager: MainLayoutManager!
    private var navigationManager: MainNavigationManager!
    
    // - Data
    var statusBarHidden = false
    var statusBarUpdateAnimation: UIStatusBarAnimation = .slide
    private var side = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutManager.viewDidAppear()
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    @IBAction func tapButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            guard let self = self else { return }
            self.tapButtonConstraintsCollection[sender.tag].constant = -15
            self.tapButtonConstraintsCollection[self.side].constant = 0
            self.view.layoutIfNeeded()
        }) { [weak self] _ in
            self?.side = sender.tag
        }
        let screenWidth = CGFloat(UIScreen.main.bounds.width)
        let yPosition = scrollView.bounds.origin.y
        let index = CGFloat(sender.tag)
        scrollView.setContentOffset(CGPoint(x: screenWidth * index, y: yPosition), animated: false)
    }
    
}

// MARK: - Action

extension MainViewController {
    
    
    
}

// MARK: - Configure

extension MainViewController {
    
    func configure() {
        configureLayoutManager()
        configureNavigationManager()
    }
    
    func configureLayoutManager() {
        layoutManager = MainLayoutManager(viewController: self)
    }
    
    func configureNavigationManager() {
        navigationManager = MainNavigationManager(viewController: self)
    }
    
}

