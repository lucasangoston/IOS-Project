//
//  FavoriteService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 23/07/2022.
//

import Foundation

protocol FavoriteListService{
    func getAnimeById(completion: @escaping (AnimeNetwork) -> Void, idAnime: String)
}
