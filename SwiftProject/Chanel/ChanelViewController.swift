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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChanelTableViewCell.identifier, for: indexPath) as! ChanelTableViewCell
        
        cell.configure(with: chanels[indexPath.row])
        
        return cell
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
