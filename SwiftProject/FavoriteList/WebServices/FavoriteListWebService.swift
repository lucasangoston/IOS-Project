//
//  FavoriteWebService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 23/07/2022.
//

import Foundation

class FavoriteListWebService: FavoriteListService {
    func getAnimeById(completion: @escaping (AnimeNetwork) -> Void, idAnime: String) {
        let url = "https://kitsu.io/api/edge/anime/" + idAnime
        
        guard let url = URL(string: url)
        else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any],
                  let datasets = json["data"] as? [String: Any] else {
                  return
            }
            
            guard let animeObject = AnimeNetwork(dict:datasets) else {
                return
            }
            
            DispatchQueue.main.async {
                completion(animeObject)
            }
        }
        dataTask.resume()
    }
}
