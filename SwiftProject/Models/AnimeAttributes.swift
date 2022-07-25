//
//  AnimeAttributes.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

class AnimeAttributes {
    let synopsis: String
    let canonicalTitle: String
    let startDate: String
    let status: String
    let posterImage: AnimePosterImage
    let coverImage: AnimeCoverImage
    var description: String {
        return "synopsis: \(self.synopsis), canonicalTitle: \(self.canonicalTitle), startDate: \(self.startDate), status: \(self.status), posterImage: \(self.posterImage), coverImage: \(self.coverImage)"
    }
    
    init(synopsis: String, canonicalTitle: String, startDate: String, status: String, posterImage: AnimePosterImage, coverImage: AnimeCoverImage) {
        self.synopsis = synopsis
        self.canonicalTitle = canonicalTitle
        self.startDate = startDate
        self.status = status
        self.posterImage = posterImage
        self.coverImage = coverImage
    }
    
    convenience init?(dict: [String: Any]) {
        guard let synopsis = dict["synopsis"] as? String,
              let canonicalTitle = dict["canonicalTitle"] as? String,
              let startDate = dict["startDate"] as? String,
              let status = dict["status"] as? String,
              let posterImage = dict["posterImage"] as? [String: Any],
              let posterImageObject = AnimePosterImage(dict: posterImage),
              let coverImage = dict["coverImage"] as? [String: Any],
              let coverImageObject = AnimeCoverImage(dict: coverImage) else {
            return nil
        }
        
        self.init(synopsis: synopsis, canonicalTitle: canonicalTitle, startDate: startDate, status: status, posterImage: posterImageObject, coverImage: coverImageObject)
    }
}
