//
//  ProfileViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 23/07/2022.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableViewChanel: UITableView!
    @IBOutlet weak var username: UILabel!
    
    var chanelService: ChanelService = ChanelWebService()
    var chanelsByUser: [UserChanel] = []
    var chanels: [Chanel] = [] {
        didSet {
            self.tableViewChanel.reloadData() // recharge la tableview
        }
    }
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewChanel.register(ProfileTableViewCell.nib(), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
        self.setUser()
        
        self.chanelService.getChanels{ chanels in
            self.chanels = chanels
        }
        
        self.chanelService.getChanelsByIdUser { chanels in
            self.chanelsByUser.append(contentsOf: chanels)
        }
        
        self.tableViewChanel.delegate = self
        self.tableViewChanel.dataSource = self
        
        self.tableViewChanel.refreshControl = myRefreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl){
        chanels.removeAll()
        chanelsByUser.removeAll()
        
        self.chanelService.getChanels{ chanels in
            self.chanels = chanels
        }
        
        self.chanelService.getChanelsByIdUser { chanels in
            self.chanelsByUser = chanels
        }
        
        self.tableViewChanel.reloadData()
        sender.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chanels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        
        //cell.configure(with: chanels[indexPath.row])
        
        return cell
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
    
    private func doesChanelIsJoin(chanels: [UserChanel], idChanel: Int) -> Bool {
        for chanel in chanels {
            print(chanel.idChanel)
            print(idChanel)
            if chanel.idChanel == idChanel{
                return true
            }
        }
        return false
    }

}
