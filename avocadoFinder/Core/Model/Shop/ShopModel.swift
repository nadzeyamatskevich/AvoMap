//
//  ShopModel.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import RealmSwift

class ShopModel: Object, Codable {
    
    @objc dynamic var id = ""
    @objc dynamic var type = ""
    @objc dynamic var address = ""
    @objc dynamic var author = ""
    @objc dynamic var latitude = ""
    @objc dynamic var longitude = ""
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var inserted_at = ""
    @objc dynamic var shopDescription = ""
    @objc dynamic var ripe = false
    @objc dynamic var currency = ""
    var recent_comments = List<CommentModel>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case address
        case author
        case latitude
        case longitude
        case name
        case recent_comments
        case description
        case price
        case inserted_at
        case ripe
        case currency
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude) ?? ""
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        shopDescription = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        price = try values.decodeIfPresent(String.self, forKey: .price) ?? ""
        inserted_at = try values.decodeIfPresent(String.self, forKey: .inserted_at) ?? ""
        ripe = try values.decodeIfPresent(Bool.self, forKey: .ripe) ?? false
        currency = try values.decodeIfPresent(String.self, forKey: .currency) ?? ""
        
        if let recent_comments = try values.decodeIfPresent([CommentModel].self, forKey: .recent_comments) {
            self.recent_comments.append(objectsIn: recent_comments)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(address, forKey: .address)
        try container.encode(author, forKey: .author)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(shopDescription, forKey: .description)
        try container.encode(price, forKey: .price)
        try container.encode(inserted_at, forKey: .inserted_at)
        try container.encode(ripe, forKey: .ripe)
        try container.encode(currency, forKey: .currency)
        try container.encode(Array(recent_comments), forKey: .recent_comments)
    }
    
}
