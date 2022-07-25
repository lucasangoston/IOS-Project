//
//  Chanel.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

class Chanel {
    let idChanel: Int
    let chanelName: String
    let theme: String
    let description: String

    internal init(idChanel: Int, chanelName: String, theme: String, description: String) {
        self.idChanel = idChanel
        self.chanelName = chanelName
        self.theme = theme
        self.description = description
    }

    convenience init?(dict: [String: Any]){
        guard let idChanel = dict["_idChanel"] as? Int,
              let chanelName = dict["_chanelName"] as? String,
              let theme = dict["_Theme"] as? String,
              let description = dict["_description"] as? String else {
            return nil
        }
        
        self.init(idChanel: idChanel, chanelName: chanelName, theme: theme, description: description)
    }
   
}
