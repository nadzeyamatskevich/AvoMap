//
//  RecipesServerManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import Moya

class RecipesServerManager {
    
    private let serverProvider = MoyaProvider<RecipesServerProvider>()
    
    func getRecipes(completion: @escaping ((_ successModel: [RecipeModel]?, _ error: ErrorModel?) -> ())) {
        serverProvider.request(.getRecipes) { (result) in
            handleResponseArray(result: result, completion: completion)
        }
    }
    
}
