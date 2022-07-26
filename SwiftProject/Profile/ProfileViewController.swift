//
//  ProfileViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 23/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableViewChanel: UITableView!
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUser()
        // Do any additional setup after loading the view.
    }


    private func setUser(){
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        self.username.text = username
    }
    
    @IBAction func logOutUser() {
        let alert = UIAlertController(title:NSLocalizedString("profileViewController.alert.title", comment: ""), message:NSLocalizedString("profileViewController.alert.message", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Default action"), style: .cancel, handler: nil ))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: ""), style: .destructive, handler: self.handleLogOut))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleLogOut(alert: UIAlertAction){
        UserDefaults.standard.removeObject(forKey: "mail")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "username")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginViewController)
    }

}
