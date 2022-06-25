//
//  RatpMeta.swift
//  Ratp
//
//  Created by Benoit Briatte on 01/06/2022.
//

import Foundation

class RatpMeta {
    var title: String
    var desc: String
    var themes: [String]
    var keywords: [String]
    
    init(title: String, desc: String, themes: [String], keywords: [String]) {
        self.title = title
        self.desc = desc
        self.themes = themes
        self.keywords = keywords
    }
    
    // convenience car le constructeur call un autre constructeur de la meme classe
    convenience init?(dict: [String: Any]) {
        guard let `default` = dict["default"] as? [String: Any],
              let title = `default`["title"] as? String,
              let desc = `default`["description"] as? String,
              let themes = `default`["theme"] as? [String],
              let keywords = `default`["keyword"] as? [String] else {
            return nil
        }
        self.init(title: title, desc: desc, themes: themes, keywords: keywords)
    }
}
