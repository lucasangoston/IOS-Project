//
//  AnimePosterImage.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

class AnimePosterImage {
    var original: String
    var description: String {
        return "posterImage: \(self.original)"
    }
    
    init(original: String) {
        self.original = original
    }
    
    convenience init?(dict: [String: Any]) {
        guard let original = dict["original"] as? String else {
            return nil
        }
        
        self.init(original: original)
    }
}
