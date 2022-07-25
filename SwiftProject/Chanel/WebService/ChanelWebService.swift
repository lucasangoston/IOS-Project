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
    
    func getChanelsByIdUser(completion: @escaping ([UserChanel]) -> Void) {
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        let url = "http://localhost:3000/userChanel/getByUserId/" + idUser
        
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
            
            let resultObjects: [UserChanel] = json.compactMap { obj in
                UserChanel(dict: obj)
            }
            
            // Obligatoire permet d'éxecuter le callback sur le thread principal: cela permet de toucher à l'UI
            DispatchQueue.main.async {
                completion(resultObjects)
            }
        }
        dataTask.resume()
    }
    
    func joinChanel(idChanel: Int) {
        guard let url = URL(string: "http://localhost:3000/userChanel/createUserChanel") else {
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
            "idChanel": idChanel,
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
    
    func quitChanel(idChanel: Int){
        let url = "http://localhost:3000/userChanel/delete/" + String(idChanel)
        
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
    
    func createChanel(chanelName: String, chanelDescription: String, chanelTheme: String) {
        guard let url = URL(string: "http://localhost:3000/chanel/createChanel") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        let usernameCurentUser = UserDefaults.standard.string(forKey: "username")
        
        guard let username = usernameCurentUser else {
            return
        }
        
        let body: [String: Any] = [
            "chanelName": chanelName,
            "Theme": chanelTheme,
            "description": chanelDescription,
            "idUser": idUser,
            "username": username
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
    
    func deleteChanel(idChanel: Int){
        let url = "http://localhost:3000/chanel/delete/" + String(idChanel)
        
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
