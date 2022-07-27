//
//  ChanelViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 21/07/2022.
//

import UIKit

class ChanelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewChanel: UITableView!
    
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
        
        self.tableViewChanel.separatorColor = UIColor.white;
        
        self.tableViewChanel.register(ChanelTableViewCell.nib(), forCellReuseIdentifier: ChanelTableViewCell.identifier)
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChanelTableViewCell.identifier, for: indexPath) as! ChanelTableViewCell
        
        cell.configure(with: chanels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let chanel = chanels[indexPath.row]
              
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        if Int(idUser) == chanel.idUser {
            let alert = UIAlertController(title: NSLocalizedString("chanelView.s", comment: "Default action"), message: NSLocalizedString("chanelView.message", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Default action"), style: .cancel, handler: nil ))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: ""), style: .destructive, handler: { action in
                self.chanelService.deleteChanel(idChanel: chanel.idChanel)
                let alert = UIAlertController(title: "Suppression", message: NSLocalizedString("chanelView.message2", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Oui", comment: ""), message: NSLocalizedString("chanelView.message3", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chanels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chanelDetail = ChanelDetailViewController()
                
        let chanel = self.chanels[indexPath.row]
        let isJoined = doesChanelIsJoin(chanels: self.chanelsByUser, idChanel: chanel.idChanel)
        
        chanelDetail.chanel = chanel
        chanelDetail.isJoined = isJoined
       
        self.navigationController!.pushViewController(chanelDetail,animated:true)
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
