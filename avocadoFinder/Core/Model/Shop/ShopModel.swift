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
    @objc dynamic var address = ""
    @objc dynamic var author = ""
    @objc dynamic var latitude = ""
    @objc dynamic var longitude = ""
    @objc dynamic var name = ""
    var recent_comments = List<CommentModel>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case address
        case author
        case latitude
        case longitude
        case name
        case recent_comments
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude) ?? ""
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        
        if let recent_comments = try values.decodeIfPresent([CommentModel].self, forKey: .recent_comments) {
            self.recent_comments.append(objectsIn: recent_comments)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(address, forKey: .address)
        try container.encode(author, forKey: .author)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(Array(recent_comments), forKey: .recent_comments)
    }
    
}
