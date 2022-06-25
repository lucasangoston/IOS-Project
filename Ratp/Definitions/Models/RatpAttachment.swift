//
//  RatpAttachment.swift
//  Ratp
//
//  Created by Benoit Briatte on 01/06/2022.
//

import Foundation

class RatpAttachment {
    var id: String
    var mimetype: String
    var title: String
    var url: String
    
    init(id: String, mimetype: String, title: String, url: String) {
        self.id = id
        self.mimetype = mimetype
        self.title = title
        self.url = url
    }
    
    convenience init?(dict: [String: Any]) {
        guard let mimetype = dict["mimetype"] as? String,
              let id = dict["id"] as? String,
              let title = dict["title"] as? String,
              let url = dict["url"] as? String else {
            return nil
        }
        self.init(id: id, mimetype: mimetype, title: title, url: url)
    }
}
