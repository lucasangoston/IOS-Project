//
//  Favoris.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 23/07/2022.
//

import Foundation

class Favorite {
    let idFavorite: Int
    let idAnime: String
    let idUser: Int

    internal init(idFavorite: Int, idAnime: String, idUser: Int) {
        self.idFavorite = idFavorite
        self.idAnime = idAnime
        self.idUser = idUser
    }

    convenience init?(dict: [String: Any]){
        guard let idFavorite = dict["_idFavorite"] as? Int,
              let idAnime = dict["_idAnime"] as? String,
              let idUser = dict["_idUser"] as? Int else {
            return nil
        }
        
        self.init(idFavorite: idFavorite, idAnime: idAnime, idUser: idUser)
    }
}
