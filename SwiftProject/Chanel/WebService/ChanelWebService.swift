//
//  ChanelWebService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

class ChanelWebService: ChanelService {
    func getChanels(completion: @escaping ([Chanel]) -> Void) {
        let urlParse = "http://localhost:3000/chanel/getAll"
        guard let url = URL(string: urlParse)
        else {
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [ [String: Any] ] else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            let posts  = json.compactMap{ post in
                Chanel(dict: post)
            }
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
    
        dataTask.resume() // start request
    }
}
