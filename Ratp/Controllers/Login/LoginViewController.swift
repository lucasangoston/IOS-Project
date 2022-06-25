//
//  LoginViewController.swift
//  Ratp
//
//  Created by Lucas Angoston on 25/06/2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!

    @IBAction func handleDatasets() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("login.title", comment: "")
        
        self.emailTextField.placeholder = NSLocalizedString("login.form.email.placeholder", comment: "")
        
        self.passwordTextField.placeholder = NSLocalizedString("login.form.password.placeholder", comment: "")
        
        self.loginButton
            .setTitle(NSLocalizedString("login.form.login.button", comment: ""),for: .normal)
        
        self.registerButton.setTitle(NSLocalizedString("login.register.button", comment: ""), for: .normal)
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func displayErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("login.form.alert.close", comment: ""), style: .cancel))
        self.present(alert, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                alert.dismiss(animated: true)
            }
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
