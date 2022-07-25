//
//  AnimeCoverImage.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

class AnimeCoverImage {
    let tiny: String
    var description: String {
        return "coverImage: \(self.tiny)"
    }
    
    init(tiny: String) {
        self.tiny = tiny
    }
    
    convenience init?(dict: [String: Any]) {
        guard let tiny = dict["tiny"] as? String else {
            return nil
        }
        
        self.init(tiny: tiny)
    }
}
