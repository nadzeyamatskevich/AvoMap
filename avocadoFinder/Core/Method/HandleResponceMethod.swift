//
//  HandleResponceMethod.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Foundation
import Moya
import Result

func handleResponse<ModelType: Decodable>(result: Result<Response, MoyaError>, completion: ((_ model: ModelType?, _ error: ErrorModel?) -> Void)) {
    
    switch result {
    case let .success(moyaResponse):
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
        if statusCode == 200 {
            var model: ModelType? = nil
            do {
                model = try JSONDecoder().decode(ModelType.self, from: data)
            } catch {
                print("JSON decode error: \(error).")
            }
            completion(model, nil)
        } else {
            let errorModel = ErrorModel(data: data)
            completion(nil, errorModel)
        }
        
    case let .failure(error):
        let errorModel = ErrorModel(error: error.localizedDescription)
        completion(nil, errorModel)
    }
    
}

func handleResponseArray<ModelType: Decodable>(result: Result<Response, MoyaError>, completion: ((_ models: [ModelType]?, _ error: ErrorModel?) -> Void)) {
    
    switch result {
    case let .success(moyaResponse):
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
        
        if statusCode == 200 {
            var modelsArray = [ModelType]()
            let json = try? moyaResponse.mapJSON() as? [String : Any]
            if let json = json {
                if let json_ = json {
                    let array = json_["data"] as! [[String : Any]]
                    for value in array {
                        let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        if let data = data {
                            let model = try? JSONDecoder().decode(ModelType.self, from: data)
                            if let model = model {
                                modelsArray.append(model)
                            }
                        }
                    }
                }
            }
            completion(modelsArray, nil)
        } else {
            let errorModel = ErrorModel(data: data)
            completion(nil, errorModel)
        }
        
    case let .failure(error):
        let errorModel = ErrorModel(error: error.localizedDescription)
        completion(nil, errorModel)
    }
    
}

func handleResponseJSONModel<ModelType: Decodable>(result: Result<Response, MoyaError>, completion: ((_ models: ModelType?, _ error: ErrorModel?) -> Void)) {
    
    switch result {
    case let .success(moyaResponse):
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
        
        if statusCode == 200 || statusCode == 201 {
            var model: ModelType? = nil
            let json = try? moyaResponse.mapJSON() as? [String : Any]
            if let json = json {
                if let json_ = json {
                    if let shop = json_["data"] as? [String : Any] {
                        let data = try? JSONSerialization.data(withJSONObject: shop, options: .prettyPrinted)
                        if let data = data {
                            model = try? JSONDecoder().decode(ModelType.self, from: data)
                        }
                    }
                }
            }
            completion(model, nil)
        } else {
            let errorModel = ErrorModel(data: data)
            completion(nil, errorModel)
        }
        
    case let .failure(error):
        let errorModel = ErrorModel(error: error.localizedDescription)
        completion(nil, errorModel)
    }
    
}

func handleEmptyResponse(result: Result<Response, MoyaError>, completion: (( _ error: ErrorModel?) -> Void)) {
    
    switch result {
    case .success(_):
        completion(nil)
    case let .failure(error):
        let errorModel = ErrorModel(error: error.localizedDescription)
        completion(errorModel)
    }
    
}
