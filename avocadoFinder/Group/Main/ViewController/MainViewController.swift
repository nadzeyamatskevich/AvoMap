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
        guard side != sender.tag else {return}

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else { return }
            self.tapButtonConstraintsCollection[sender.tag].constant = -10
            self.tapButtonConstraintsCollection[self.side].constant = 0
            self.view.layoutIfNeeded()
        }) { [weak self] _ in
            self?.side = sender.tag
        }
        self.configureIcons(index: sender.tag)
        let screenWidth = CGFloat(UIScreen.main.bounds.width)
        let yPosition = scrollView.bounds.origin.y
        let index = CGFloat(sender.tag)

        scrollView.setContentOffset(CGPoint(x: screenWidth * index, y: yPosition), animated: false)
    }
    
    func configureIcons(index: Int) {
        for i in 0..<tapBarImageViewCollection.count {
            if i == index {
                tapBarImageViewCollection[i].image = UIImage(named: SelectedImage.allCases[i].rawValue)
            } else {
                tapBarImageViewCollection[i].image = UIImage(named: NotSelectedImage.allCases[i].rawValue)
            }
        }
    }
    
}

// MARK: - Action

extension MainViewController {

    enum NotSelectedImage: String, CaseIterable {
        case news
        case map
        case settings

        init?(id : Int) {
            switch id {
            case 1: self = .news
            case 2: self = .map
            case 3: self = .settings
            default: return nil
            }
        }
    }
    
    enum SelectedImage: String, CaseIterable {
        case newsSelect
        case mapSelect
        case settingsSelect

        init?(id : Int) {
            switch id {
            case 1: self = .newsSelect
            case 2: self = .mapSelect
            case 3: self = .settingsSelect
            default: return nil
            }
        }
    }

}

// MARK: - Configure

extension MainViewController {
    
    func configure() {
        configureLayoutManager()
        configureNavigationManager()

        configureIcons(index: side)
    }
    
    func configureLayoutManager() {
        layoutManager = MainLayoutManager(viewController: self)
    }
    
    func configureNavigationManager() {
        navigationManager = MainNavigationManager(viewController: self)
    }
    
}

