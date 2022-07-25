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
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewFavoriteList.separatorColor = UIColor.white;
        
        self.tableViewFavoriteList.register(FavoriteListTableViewCell.nib(), forCellReuseIdentifier: FavoriteListTableViewCell.identifier)
        
        self.favoriteService.getFavoritesByIdUser{ favorites in
            self.getIdAnimeFavorite(favorites: favorites)
        }
        
        self.tableViewFavoriteList.delegate = self
        self.tableViewFavoriteList.dataSource = self
        
        self.tableViewFavoriteList.refreshControl = myRefreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl){
        favorites.removeAll()
        favoriteList.removeAll()
        
        self.favoriteService.getFavoritesByIdUser{ favorites in
            self.getIdAnimeFavorite(favorites: favorites)
        }
        
        self.tableViewFavoriteList.reloadData()
        sender.endRefreshing()
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
        let animeTitle = favoriteList[indexPath.row].attributes.canonicalTitle
        
        
        print(favorites)
        
        if editingStyle == .delete {
          let alert = UIAlertController(title: "Suppression", message: "Voulez-vous vraiment supprimé \(animeTitle) de votre liste ?", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Default action"), style: .cancel, handler: nil ))
          
          alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: ""), style: .destructive, handler: { action in
              
              
              self.favoriteService.deleteFavorite(idFavorite: 1)
          }))
          
          self.present(alert, animated: true, completion: nil)
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeDetail = AnimeDetailViewController()
        
        let anime = favoriteList[indexPath.row]
        
        let isFavorite = true
        let idFavorite = getIdFavorite(favorites: self.favorites, idAnime: anime.id)
        
        animeDetail.idFavorite = idFavorite
        animeDetail.isFavorite = isFavorite
        animeDetail.anime = anime
       
        self.navigationController?.pushViewController(animeDetail, animated: true)
    }
    
    private func getIdAnimeFavorite(favorites: [Favorite]) {
        
        for favorite in favorites {
            self.favoriteListService.getAnimeById(completion: { favoriteList in
                self.favoriteList.append(favoriteList)
            }, idAnime: favorite.idAnime)
        }
    }
    
    func getIdFavorite(favorites: [Favorite], idAnime: String) -> Int {
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        
        guard let idUser = idCurentUser else {
            return 0
        }

        for favorite in favorites {
            if favorite.idUser == Int(idUser) && favorite.idAnime == idAnime {
                return favorite.idFavorite
            }
        }
        return 0
    }
}
