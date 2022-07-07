//
//  AnimeNetwork.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 30/06/2022.
//

import Foundation

class AnimeNetwork {
    let id: String
    let type: String
    let attributes: AnimeAttributes
    var description: String {
        return "AnimeId: \(self.id), type: \(self.type), attributes: \(self.attributes)"
    }
    
    init(id: String, type: String, attributes: AnimeAttributes) {
        self.id = id
        self.type = type
        self.attributes = attributes
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let type = dict["type"] as? String,
              let attributes = dict["attributes"] as? [String: Any],
              let attributesObject = AnimeAttributes(dict: attributes) else {
            return nil
        }
      
        self.init(id: id, type: type, attributes: attributesObject)
    }
}
