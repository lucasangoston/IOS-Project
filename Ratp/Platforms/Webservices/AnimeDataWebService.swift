//
//  AnimeDatasetWebService.swift
//  ios_project
//
//  Created by Lucas Angoston on 25/06/2022.
//

import Foundation

class AnimeDataWebService: AnimeDataService {
    
    func fetchDatasets(completion: @escaping ([AnimeData]) -> Void) {
        guard let url = URL(string: "https://kitsu.io/api/edge/anime/1") else {
            completion([]) // impossible de créer l'url
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            // try? ---> si la fonction lève une exception retourne nil dans la variable json
            // as? --> permet de tenter de caster, s'il n'y arrive pas retourne nil dans la variable json
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any],
                  let data = json["data"] as? [ [String: Any] ] else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            let datasetObjects: [AnimeData] = data.compactMap { obj in
                return AnimeData(dict: obj)
            }
            // Obligatoire permet d'éxecuter le callback sur le thread principal: cela permet de toucher à l'UI
            DispatchQueue.main.async {
                completion(datasetObjects)
            }
            
        }
        dataTask.resume() // OBLIGATOIRE ! permet de lancer la requete !
    }
}
