//
//  NewsAndBlogServerManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Moya

class NewsAndBlogServerManager {
    
    private let serverProvider = MoyaProvider<NewsServerProvider>()
    
    func getNews(completion: @escaping ((_ successModel: [NewsModel]?, _ error: ErrorModel?) -> ())) {
        serverProvider.request(.getNews) { (result) in
            handleResponseArray(result: result, completion: completion)
        }
    }
    
}
