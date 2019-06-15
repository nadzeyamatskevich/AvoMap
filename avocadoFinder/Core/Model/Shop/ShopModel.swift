//
//  ShopModel.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import RealmSwift

class ShopModel: Object, Codable {
    
  /*  "address": "Nezav. st, 12",
    "author": "Author 2",
    "id": "dcd8e8f8-1f59-43de-8ab1-29544e92ac95",
    "latitude": "54.863078000",
    "longitude": "28.336200000",
    "name": "Shop 2",
    "recent_comments": []
    */
    
    @objc dynamic var id = ""
    @objc dynamic var address = ""
    @objc dynamic var author = ""
    @objc dynamic var latitude = ""
    @objc dynamic var longitude = ""
    @objc dynamic var name = ""
    
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
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(address, forKey: .address)
        try container.encode(author, forKey: .author)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
    }
    
}
