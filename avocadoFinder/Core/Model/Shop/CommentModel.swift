//
//  CommentModel.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import RealmSwift

class CommentModel: Object, Codable {
    
    /*
 "author": "User 1",
 "body": "good, 11/10",
 "id": "93f0d9d7-49f3-4c44-83c8-b46bafb45e3f"*/
    
    @objc dynamic var id = ""
    @objc dynamic var author = ""
    @objc dynamic var body = ""
    @objc dynamic var inserted_at = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case body
        case inserted_at
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? ""
        inserted_at = try values.decodeIfPresent(String.self, forKey: .inserted_at) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(body, forKey: .body)
        try container.encode(inserted_at, forKey: .inserted_at)
    }
    
}
