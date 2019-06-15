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
    case getShopInfo(shopID: Int)
    case addComment(shopID: Int, comment: CommentModel)
    case getComments(shopID: Int)
    
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
            return .requestJSONEncodable(shop)
        case .getShopInfo:
            return .requestPlain
        case .addComment(_ ,let comment):
            return .requestJSONEncodable(comment)
        case .getComments:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ServerAuthorizedHeaders
    }
    
}
