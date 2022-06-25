//
//  RegisterViewController.swift
//  Ratp
//
//  Created by Kong on 6/11/22.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    @IBAction func handleDatasets() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("register.title", comment: "")
        
        self.nameTextField.placeholder = NSLocalizedString("register.form.name.placeholder", comment: "")
        
        self.emailTextField.placeholder = NSLocalizedString("register.form.email.placeholder", comment: "")
        
        self.passwordTextField.placeholder = NSLocalizedString("register.form.password.placeholder", comment: "")
        
        self.registerButton.setTitle(NSLocalizedString("register.button", comment: ""), for: .normal)
        
        self.signInButton
            .setTitle(NSLocalizedString("register.button.login", comment: ""),for: .normal)
        
        self.nameTextField.delegate = self
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
