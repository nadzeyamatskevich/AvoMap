//
//  NewsModel.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import RealmSwift

class NewsModel: Object, Codable {
    
    /*
     "body": "lorem ipsum? 1",
     "id": "e5de7b95-72e0-451c-89df-5d6c625d3eef",
     "subtitle": "Subtitle 1",
     "title": "Title 1"
     */
    
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var subtitle = ""
    @objc dynamic var body = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case body
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(body, forKey: .body)
    }
    
}
