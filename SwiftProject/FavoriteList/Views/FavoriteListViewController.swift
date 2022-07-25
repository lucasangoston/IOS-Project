//
//  FavoriteListViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 23/07/2022.
//

import UIKit

class FavoriteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViewFavoriteList: UITableView!
    
    var favoriteListService: FavoriteListService = FavoriteListWebService()
    var favoriteService: FavoriteService = FavoriteWebService()
    var favorites: [Favorite] = []
    var favoriteList: [AnimeNetwork] = [] {
        didSet {
            self.tableViewFavoriteList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewFavoriteList.separatorColor = UIColor.white;
        
        self.tableViewFavoriteList.register(FavoriteListTableViewCell.nib(), forCellReuseIdentifier: FavoriteListTableViewCell.identifier)
        
        self.favoriteService.getFavoritesByIdUser{ favorites in
            self.getIdAnimeFavorite(favorites: favorites)
        }
        
        self.tableViewFavoriteList.delegate = self
        self.tableViewFavoriteList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListTableViewCell.identifier, for: indexPath) as! FavoriteListTableViewCell
        
        getIdAnimeFavorite(favorites: self.favorites)
        
       cell.configure(with: favoriteList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeDetail = AnimeDetailViewController()
        
        let anime = favoriteList[indexPath.row]
        
        let isFavorite = false
        
        animeDetail.isFavorite = isFavorite
        animeDetail.anime = anime
       
        self.navigationController?.pushViewController(animeDetail, animated: true)
    }
    
    func getIdAnimeFavorite(favorites: [Favorite]) {
        for favorite in favorites {
            self.favoriteListService.getAnimeById(completion: { favoriteList in
                self.favoriteList.append(favoriteList)
            }, idAnime: favorite.idAnime)
        }
    }
}
