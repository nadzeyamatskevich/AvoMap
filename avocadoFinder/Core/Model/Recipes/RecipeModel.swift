//
//  RecipeModel.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import RealmSwift

class RecipeModel: Object, Codable {

    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var subtitle = ""
    @objc dynamic var body = ""
    @objc dynamic var image_url = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case body
        case image_url
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? ""
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(body, forKey: .body)
        try container.encode(image_url, forKey: .image_url)
    }
    
}
