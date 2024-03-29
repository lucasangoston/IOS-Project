//
//  AnimeNetworkWebService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

class AnimeNetworkWebService: AnimeNetworkService {
    
    func getAnimesByTrending(completion: @escaping ([AnimeNetwork]) -> Void) {
        guard let url = URL(string: "https://kitsu.io/api/edge/trending/anime")
        else {
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            
            // try? ---> si la fonction lève une exception retourne nil dans la variable json
            // as? --> permet de tenter de caster, s'il n'y arrive pas retourne nil dans la variable json
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any],
                  let datasets = json["data"] as? [ [String: Any] ] else {
                DispatchQueue.main.async {
                    completion([])
                }
                
                return
            }
            let resultObjects: [AnimeNetwork] = datasets.compactMap { obj in
                return AnimeNetwork(dict: obj)
            }
            // Obligatoire permet d'éxecuter le callback sur le thread principal: cela permet de toucher à l'UI
            DispatchQueue.main.async {
                completion(resultObjects)
            }
            
        }
        dataTask.resume()
    }
    
    func getAnimes(completion: @escaping ([AnimeNetwork]) -> Void, pageLimit: String, offset: String, mySearch: String)
    {
        let url = "https://kitsu.io/api/edge/anime?page[limit]=" + pageLimit + "&page[offset]=" + offset + mySearch
        
        
        guard let url = URL(string: url)
        else {
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            
            // try? ---> si la fonction lève une exception retourne nil dans la variable json
            // as? --> permet de tenter de caster, s'il n'y arrive pas retourne nil dans la variable json
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any],
                  let datasets = json["data"] as? [ [String: Any] ] else {
                DispatchQueue.main.async {
                    completion([])
                }
                
                return
            }
            let resultObjects: [AnimeNetwork] = datasets.compactMap { obj in
                return AnimeNetwork(dict: obj)
            }
            // Obligatoire permet d'éxecuter le callback sur le thread principal: cela permet de toucher à l'UI
            DispatchQueue.main.async {
                completion(resultObjects)
            }
            
        }
        dataTask.resume()
    }
}
