//
//  ShopServerProvider.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Moya

enum ShopServerProvider {
    
    case getShops
    case addShop(shop: ShopModel)
    case getShopInfo(shopID: String)
    case addComment(shopID: String, comment: CommentModel)
    case getComments(shopID: String)
    
}

extension ShopServerProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getShops:
            return "/shops"
        case .addShop:
            return "/shops"
        case .getShopInfo(let shopID):
            return "/shops/\(shopID)"
        case .addComment(let shopID, _):
            return "/shops/\(shopID)/comments"
        case .getComments(let shopID):
            return "/shops/\(shopID)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getShops, .getComments, .getShopInfo:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .getShops:
            return .requestPlain
        case .addShop(let shop):
            let params = ["shop": ["name": shop.name, "author": shop.author, "address": shop.address, "latitude": shop.latitude, "longitude": shop.longitude, "description": shop.shopDescription]]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .getShopInfo:
            return .requestPlain
        case .addComment(_ ,let comment):
            let params = ["comment": ["author": comment.author, "body": comment.body]]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .getComments:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ServerAuthorizedHeaders
    }
    
}
