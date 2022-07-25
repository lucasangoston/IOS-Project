//
//  CommentWebService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 24/07/2022.
//

import Foundation

class CommentWebService : CommentService {
    func getCommentsByIdChanel(completion: @escaping ([Comment]) -> Void, idChanel: Int) {
        let url = "http://localhost:3000/comment/getCommentByChanelId/" + String(idChanel)
        
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
            
            let resultObjects: [Comment] = json.compactMap { obj in
                Comment(dict: obj)
            }
            
            // Obligatoire permet d'éxecuter le callback sur le thread principal: cela permet de toucher à l'UI
            DispatchQueue.main.async {
                completion(resultObjects)
            }
            
        }
        dataTask.resume()
    }
    func createComment(idChanel: Int ,content: String) {
        guard let url = URL(string: "http://localhost:3000/comment/createComment") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        let nameCurrentUser = UserDefaults.standard.string(forKey: "username")
        
        guard let nameUser = nameCurrentUser else {
            return
        }
        
        let body: [String: Any?] = [
            "idChanel": 1,
            "idUser": idUser,
            "username": nameUser,
            "content": content,
            "createDate": ""
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
}
