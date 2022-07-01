//
//  AnimeAttributes.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 30/06/2022.
//

import Foundation

class AnimePosterImage {
    let tiny: String
    var description: String {
        return "posterImage: \(self.tiny)"
    }
    
    init(tiny: String) {
        self.tiny = tiny
    }
    
    convenience init?(dict: [String: Any]) {
        guard let tiny = dict["tiny"] as? String else {
            return nil
        }
        
        
        
        self.init(tiny: tiny)
        
        print(description)
    }
}
