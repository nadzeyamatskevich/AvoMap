//
//  NewsServerProvider.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Moya

enum NewsServerProvider {
    
    case getNews
    
}

extension NewsServerProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/news"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .getNews:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ServerAuthorizedHeaders
    }
    
}
