//
//  FavoriteWebService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 22/07/2022.
//

import Foundation

class FavoriteWebService: FavoriteService {
    func getFavoritesByIdUser(completion: @escaping ([Favorite]) -> Void) {
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        let url = "http://localhost:3000/favorite/getfavoritesByUserId/" + idUser
        
        guard let url = URL(string: url)
        else {
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in

            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [[String: Any]] else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            let resultObjects: [Favorite] = json.compactMap { obj in
                Favorite(dict: obj)
            }
            
            // Obligatoire permet d'éxecuter le callback sur le thread principal: cela permet de toucher à l'UI
            DispatchQueue.main.async {
                completion(resultObjects)
            }
            
        }
        dataTask.resume()
    }
    
    func createFavorite(idAnime: String) {
        guard let url = URL(string: "http://localhost:3000/favorite/createFavorite") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        let body: [String: Any] = [
            "idAnime": idAnime,
            "idUser": idUser
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(response)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func deleteFavorite(idFavorite: Int){
        let url = "http://localhost:3000/favorite/delete/" + String(idFavorite)
        
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
