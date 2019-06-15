//
//  MapServerManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Moya

class MapServerManager {
    
    private let serverProvider = MoyaProvider<ShopServerProvider>()
    
    func getShops(completion: @escaping ((_ successModel: [ShopModel]?, _ error: ErrorModel?) -> ())) {
        serverProvider.request(.getShops) { (result) in
            handleResponseArray(result: result, completion: completion)
        }
    }
    
}
