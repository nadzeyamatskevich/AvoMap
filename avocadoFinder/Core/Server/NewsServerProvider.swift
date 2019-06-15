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
    case dowmloadImage(url: String)
    
}

extension NewsServerProvider: TargetType {
    
    var baseURL: URL {
        switch self {
        case .dowmloadImage(let url):
            return URL(string: url)!
        default:
            return URL(string: Constants.baseURL)!
        }
        
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/news"
        case .dowmloadImage:
            return ""
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
        case .dowmloadImage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ServerAuthorizedHeaders
    }
    
}
