//
//  HomeViewController.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 30/06/2022.
//

import UIKit
import WebKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    var animeNetworkService: AnimeNetworkService = AnimeNetworkWebService()
    var animesList: [[AnimeNetwork]] = []
    var animes: [AnimeNetwork] = [] {
        didSet {
            self.tableView.reloadData() // recharge la tableview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        self.animeNetworkService.getAnimesByTrending { animes in
            self.animes = animes
        }
        
        self.animesList.append(animes)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        cell.parent = self
        cell.configure(with: self.animes)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animesList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.animes[indexPath.row])
    }
}
