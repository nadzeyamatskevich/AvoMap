//
//  RecipesServerProvider.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import Moya

enum RecipesServerProvider {
    
    case getRecipes
    
}

extension RecipesServerProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return "/recipes"
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
        case .getRecipes:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ServerAuthorizedHeaders
    }
    
}
