//
//  AttributeDataset.swift
//  ios_project
//
//  Created by Lucas Angoston on 25/06/2022.
//

import Foundation

class AnimeAttribute {
    var synopsis : String
    var canonicalTitle : String
    var startDate : String
    var endDate : String
    var status: String
    var episodeCount : String
    
    init(synopsis: String, canonicalTitle: String, startDate: String, endDate: String, status: String, episodeCount: String) {
        self.synopsis = synopsis
        self.canonicalTitle = canonicalTitle
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.episodeCount = episodeCount
    }
    
    convenience init?(dict: [String: Any]) {
        guard let synosis = dict["synopsis"] as? String,
              let canonicalTitle = dict["canonicalTitle"] as? String,
              let startDate = dict["startDate"] as? String,
              let endDate = dict["endDate"] as? String,
              let status = dict["status"] as? String,
              let episodeCount = dict["episodeCount"] as? String else {
            return nil
        }
        
        self.init(synopsis: synosis, canonicalTitle: canonicalTitle, startDate: startDate, endDate: endDate, status: status, episodeCount: episodeCount)
    }
    
}
