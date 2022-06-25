//
//  AnimeDataset.swift
//  ios_project
//
//  Created by Lucas Angoston on 25/06/2022.
//

import Foundation

class AnimeData {
    var id: String
    var type: String
    var attributes: AnimeAttribute
    
    init(id: String, type: String, attributes: AnimeAttribute) {
        self.id = id
        self.type = type
        self.attributes = attributes
    }
    
    convenience init?(dict: [String: Any]) {
        guard let data = dict["data"] as? [String: Any],
              let id = data["id"] as? String,
              let type = data["type"] as? String,
              let attributes = data["attributes"] as? [String: Any],
              let attributesObjects = AnimeAttribute(dict: attributes) else {
            return nil
        }
        
        self.init(id: id, type: type, attributes: attributesObjects)
    }
}
