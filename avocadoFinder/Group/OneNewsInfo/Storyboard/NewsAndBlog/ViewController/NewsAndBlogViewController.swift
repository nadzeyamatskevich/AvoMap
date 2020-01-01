//
//  NewsAndBlogViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class NewsAndBlogViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - Manager
    fileprivate var layoutManager: NewsAndBlogLayoutManager!
    fileprivate var dataSource: NewsAndBlogDataSourceManager!
    fileprivate var coordinatorManager: NewsAndBlogCoordinatorManager!
    fileprivate var serverManager = NewsAndBlogServerManager()
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        layoutManager.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

// MARK: -
// MARK: - Data source delegate

extension NewsAndBlogViewController: NewsAndBlogDataSourceDelegate {
    func didTapOnCell(news: NewsModel, image: UIImage?) {
       coordinatorManager.pushOneNewsInfoViewController(news: news, image: image)
    }
    
}

// MARK: -
// MARK: - Server

extension NewsAndBlogViewController {
    
    func getNewsRequest(completion: @escaping ((_ successModel: [NewsModel]?, _ error: ErrorModel?) -> ())) {
        serverManager.getNews(completion: completion)
    }
    
    func updateData(news: [NewsModel]) {
        dataSource.news = news
        dataSource.update()
    }
    
}

// MARK: -
// MARK: - Configure

extension NewsAndBlogViewController {
    
    func configure() {
        configureLayoutManager()
        configureDataSource()
        configureCoordinatorManager()
    }
    
    func configureLayoutManager() {
        layoutManager = NewsAndBlogLayoutManager(viewController: self)
    }
    
    func configureCoordinatorManager() {
        coordinatorManager = NewsAndBlogCoordinatorManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = NewsAndBlogDataSourceManager(tableView: tableView)
        dataSource.delegate = self
    }
    
}
