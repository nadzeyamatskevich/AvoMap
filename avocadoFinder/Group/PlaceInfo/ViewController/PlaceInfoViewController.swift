//
//  PlaceInfoViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import HPGradientLoading

class PlaceInfoViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableVIew: UITableView!
    
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
        getServerData()
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
                strongSelf.showAlert(title: "Ура!", message: "Комментарий добавлен :)", completion: {
                    strongSelf.getShopInfo(shopID: strongSelf.shop.id)
                    UserDefaults.standard.set(comment.author, forKey: UserDefaultsEnum.authorNameKey.rawValue)
                })
            }
        }
    }
    
    func getShopInfoRequest(shopID: String, completion: @escaping ((_ successModel: ShopModel?, _ error: ErrorModel?) -> ())) {
        serverManager.getShopInfo(shopID: shopID, completion: completion)
    }
    
    func getShopInfo(shopID: String) {
        HPGradientLoading.shared.showLoading()
        getShopInfoRequest(shopID: shopID) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                HPGradientLoading.shared.dismiss()
                strongSelf.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if let response = response {
                strongSelf.dataSource.shop = response
                strongSelf.update()
                HPGradientLoading.shared.dismiss()
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
        configureLoader()
    }
    
    func configureLayoutManager() {
        layoutManager = PlaceInfoLayoutManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = PlaceInfoDataSource(tableView: tableVIew)
        dataSource.addCommentDelegate = self
        dataSource.shop = shop
    }
    
    func getServerData() {
        getShopInfo(shopID: shop.id)
    }
    
}


