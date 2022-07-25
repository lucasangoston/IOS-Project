//
//  RegisterViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 22/07/2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userRegister: UIButton!
    
    var userMail: Bool!
    var registerService: RegisterService = RegisterWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userRegister.isEnabled = false;
        let textfields : [UITextField] = [username, mail, password]
        
        for textfield in textfields {
          textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBAction func registerUser(){
        
        guard let username = self.username.text else {
            return
        }
        
        guard let mail = self.mail.text else {
            return
        }
        
        guard let password = self.password.text else {
            return
        }
        
       /*   self.userService.getUserByMail(completion: { user in
            self.configure(with: user.mail)
        }, mail: mail) */
       
        if(self.userMail == nil){
            if(password.count >= 8){
                if(self.isValidEmail(mail)){
                    self.registerService.register(username: username, mail: mail, password: password)
                    let alert = UIAlertController(title: "Inscription Réussie !", message: "Vous n'avez plus qu'à vous connecter.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Super", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Mauvais format Email", message: "Votre email n'a pas le bon format souhaité. (exemple@test.com).", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Votre mot de passe est trop court", message: "Votre mot de passe à besoin d'au moins 8 caractères.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ce mail existe déjà", message: "Essayez de vous connectez plutôt.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if mail != nil && mail.text != "" &&
            password != nil && password.text != "" &&
            username.text != "" &&
            username != nil  {
            
            userRegister.isEnabled = true
            
        } else {
            userRegister.isEnabled = false
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
