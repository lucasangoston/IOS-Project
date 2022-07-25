//
//  LoginViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 22/07/2022.
//

import UIKit

class LoginViewController: UIViewController {

    var loginService: LoginService = LoginWebService()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        login.isEnabled = false;
        let textfields : [UITextField] = [mail, password]
        
        for textfield in textfields {
          textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    @IBAction func handleLoginButton(){
    
        loginService.login(mail: mail.text!, password: password.text!)
        let mail = UserDefaults.standard.string(forKey: "mail")
         
        if let user = mail {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        } else {
            let alert = UIAlertController(title: "Identifiants Incorrects", message: "Veuillez essayez de nouveau", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if mail != nil && mail.text != "" &&
            password != nil && password.text != "" {
            login.isEnabled = true
        } else {
            login.isEnabled = false
        }
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