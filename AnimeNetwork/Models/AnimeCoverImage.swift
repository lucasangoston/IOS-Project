//
//  AnimeCoverImage.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 30/06/2022.
//

import Foundation

class AnimeCoverImage {
    let original: String
    var description: String {
        return "coverImage: \(self.original)"
    }
    
    init(original: String) {
        self.original = original
    }
    
    convenience init?(dict: [String: Any]) {
        guard let original = dict["original"] as? String else {
            return nil
        }
        
        self.init(original: original)
        
        print(description)
    }
}
