//
//  RegisterWebService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 22/07/2022.
//

import Foundation

class RegisterWebService : RegisterService {
    func register(username: String, mail: String, password: String) {
        guard let url = URL(string: "http://localhost:3000/user/createUser") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let body: [String: Any] = [
            "name": username,
            "mail": mail,
            "password": password
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
                
                guard let responseParsed = response as? [String: Any] else {
                    return
                }
                
            } catch {
            }
        }
        task.resume()
        
        return
    }

}
