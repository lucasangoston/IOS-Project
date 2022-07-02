//
//  AnimeAttributes.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 30/06/2022.
//

import Foundation
import UIKit

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
        
        print(description)
    }
}
