//
//  ErrorModel.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import SwiftyJSON

class ErrorModel {
    
    private var codes = [String]()
    private var messages = [String]()
    private var reasons = [String]()
    
    init(data: Data) {
        self.parseJSON(data: data)
    }
    
    init(error: String) {
        self.messages.append(error)
    }
    
    public var message: String {
        get {
            var msg = ""
            for message in messages {
                msg += msg.isEmpty ? "" : "\n"
                msg += message
            }
            return msg
        }
    }
    
    private func parseJSON(data: Data) {
        let json = try? JSON(data: data)
        let errors = json?["errors"].dictionary ?? [:]
        
        for (key, value) in errors {
            let reason = key
            self.reasons.append(reason)
            
            let values = value.array ?? []
            for item in values {
                let code = item["code"].string ?? ""
                let message = item["message"].string ?? ""
                
                self.codes.append(code)
                self.messages.append(message)
            }
            
        }
        
        if self.codes.isEmpty {
            let error = json?.dictionary ?? [:]
            let message = error["error"]?.string ?? ""
            let reason = error["data"]?["reason"].string ?? ""
            
            self.codes.append("")
            self.messages.append(message)
            self.reasons.append(reason)
        }
        
        if self.codes.isEmpty {
            if let errorMessage = json?["error_message"].string {
                self.codes.append("")
                self.messages.append(errorMessage)
            }
        }
    }
    
}
