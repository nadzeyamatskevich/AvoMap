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
    //fileprivate var layoutManager: ShoppingListMenuLayoutManager!
    fileprivate var dataSource: NewsAndBlogDataSourceManager!
    
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

}

// MARK: -
// MARK: - Data source delegate

extension NewsAndBlogViewController: NewsAndBlogDataSourceDelegate {
    func didTapOnCell(post: Int) {
        let postViewController = UIStoryboard(storyboard: .oneNews).instantiateInitialViewController() as! OneNewsInfoViewController
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

extension NewsAndBlogViewController {
    
    func configure() {
        configureLayoutManager()
        configureDataSource()
    }
    
    func configureLayoutManager() {
        //layoutManager = ShoppingListMenuLayoutManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = NewsAndBlogDataSourceManager(tableView: tableView)
        dataSource.delegate = self
    }
    
}
