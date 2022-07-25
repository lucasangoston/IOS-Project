//
//  FavoriteService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 22/07/2022.
//

import Foundation

protocol FavoriteService {
    func createFavorite(idAnime: String)
    
    func getFavoritesByIdUser(completion: @escaping ([Favorite]) -> Void)
    
    func deleteFavorite(idFavorite: Int)
}
