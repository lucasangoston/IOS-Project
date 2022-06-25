//
//  RatpDatasetWebService.swift
//  Ratp
//
//  Created by Benoit Briatte on 02/06/2022.
//

import Foundation

class RatpDatasetWebService: RatpDatasetService {
    
    func fetchDatasets(completion: @escaping ([RatpDataset]) -> Void) {
        guard let url = URL(string: "https://data.ratp.fr/api/v2/catalog/datasets?limit=100&offset=0&timezone=UTC") else {
            completion([]) // impossible de créer l'url
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            // try? ---> si la fonction lève une exception retourne nil dans la variable json
            // as? --> permet de tenter de caster, s'il n'y arrive pas retourne nil dans la variable json
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any],
                  let datasets = json["datasets"] as? [ [String: Any] ] else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            let datasetObjects: [RatpDataset] = datasets.compactMap { obj in
                return RatpDataset(dict: obj)
            }
            // Obligatoire permet d'éxecuter le callback sur le thread principal: cela permet de toucher à l'UI
            DispatchQueue.main.async {
                completion(datasetObjects)
            }
            
        }
        dataTask.resume() // OBLIGATOIRE ! permet de lancer la requete !
    }
}
