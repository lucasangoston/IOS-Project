import Foundation

class LoginWebService: LoginService {
    let defaults = UserDefaults.standard
    
    func login(mail: String, password: String) {
        guard let url = URL(string: "http://localhost:3000/user/checkLogin") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let body: [String: Any] = [
            "mail": mail,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data,
                      
                    error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                guard let responseParsed = response as? [String: Any] else {
                    return
                }
                    
                guard let id = responseParsed["_id"],
                      let mail = responseParsed["_mail"],
                      let name = responseParsed["_name"] else {
                    return
                }
                    
                self.defaults.set(id, forKey: "id")
                self.defaults.set(mail, forKey: "mail")
                self.defaults.set(name, forKey: "username")
                
            } catch {
                
            }
        }
        task.resume()
        
        return
    }
}
