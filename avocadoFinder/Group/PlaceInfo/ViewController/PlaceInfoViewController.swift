//
//  PlaceInfoViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import HPGradientLoading
import Firebase

class PlaceInfoViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var navBar: UIImageView!
    
    // - Manager
    fileprivate var layoutManager: PlaceInfoLayoutManager!
    fileprivate var dataSource: PlaceInfoDataSource!
    fileprivate var serverManager = PlaceInfoServerManager()
    
    // - Data
    var shop = ShopModel()
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func update() {
        tableVIew.reloadData()
    }
    
}

// MARK: -
// MARK: - Actions

extension PlaceInfoViewController {
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: -
// MARK: - Data source delegate

extension PlaceInfoViewController: PlaceInfoDataSourceDelegate {
    
    func addCommentAction(comment: CommentModel) {
        addComment(comment: comment)
    }
    
    func showErrorAlert(message: String) {
        self.showAlert(title: "Упс, ошибка!", message: message)
    }
    
}

// MARK: -
// MARK: - Server

extension PlaceInfoViewController {
    
    func postCommentRequest(comment: CommentModel, completion: @escaping ((_ successModel: CommentModel?, _ error: ErrorModel?) -> ())) {
        serverManager.postComment(shopID: shop.id, comment: comment, completion: completion)
    }
    
    func addComment(comment: CommentModel) {
        HPGradientLoading.shared.showLoading()
        postCommentRequest(comment: comment) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                HPGradientLoading.shared.dismiss()
                strongSelf.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if response != nil {
                HPGradientLoading.shared.dismiss()
                strongSelf.showAlert(title: "Ура!", message: "Комментарий добавлен :)", completion: nil)
                self?.addAnalyticsEventAddComment()
                strongSelf.getShopInfo(shopID: strongSelf.shop.id)
                KeychainManager.shared.saveName(comment.author)
            }
        }
    }
    
    func getShopInfoRequest(shopID: String, completion: @escaping ((_ successModel: ShopModel?, _ error: ErrorModel?) -> ())) {
        serverManager.getShopInfo(shopID: shopID, completion: completion)
    }
    
    func getShopInfo(shopID: String) {
        getShopInfoRequest(shopID: shopID) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if let response = response {
                strongSelf.shop = response
                strongSelf.dataSource.shop = response
                strongSelf.update()
            }
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension PlaceInfoViewController {
    
    func configure() {
        configureLayoutManager()
        configureDataSource()
        addAnalyticsEvent()

        if shop.type == "\(PlaceType.food_establishment_mango)" || shop.type == "\(PlaceType.store_mango)" {
            navBar.image = UIImage(named: "mangoNavBar")
        } else {
            navBar.image = UIImage(named: "navBarBg")
        }
    }
    
    func configureLayoutManager() {
        layoutManager = PlaceInfoLayoutManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = PlaceInfoDataSource(tableView: tableVIew)
        dataSource.addCommentDelegate = self
        dataSource.shop = shop
    }
    
    func addAnalyticsEvent() {
        Analytics.logEvent("open_place", parameters: [
            "type": self.shop.type as NSObject
        ])
    }
    
    func addAnalyticsEventAddComment() {
        Analytics.logEvent("added_comment", parameters: [
            "type": self.shop.type as NSObject
        ])
    }
    
}


