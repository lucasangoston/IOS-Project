//
//  UserChanel.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 25/07/2022.
//

import Foundation

class UserChanel {
    let idChanel: Int
    let idUser:Int

    internal init(idChanel: Int, idUser: Int) {
        self.idChanel = idChanel
        self.idUser = idUser
    }

    convenience init?(dict: [String: Any]){
        guard let idChanel = dict["_idChanel"] as? Int,
              let idUser = dict["_idUser"] as? Int else {
            return nil
        }
        
        self.init(idChanel: idChanel, idUser: idUser)
    }
   
}
