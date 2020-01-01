//
//  PlaceInfoServerManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/7/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Moya

class PlaceInfoServerManager {
    
    private let serverProvider = MoyaProvider<ShopServerProvider>()
    
    func postComment(shopID: String, comment: CommentModel, completion: @escaping ((_ successModel: CommentModel?, _ error: ErrorModel?) -> ())) {
        serverProvider.request(.addComment(shopID: shopID, comment: comment)) { (result) in
            handleResponseJSONModel(result: result, completion: completion)
        }
    }
    
    func getShopInfo(shopID: String, completion: @escaping ((_ successModel: ShopModel?, _ error: ErrorModel?) -> ())) {
        serverProvider.request(.getShopInfo(shopID: shopID)) { (result) in
            handleResponseJSONModel(result: result, completion: completion)
        }
    }
    
}
