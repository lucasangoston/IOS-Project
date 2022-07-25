//
//  SearchViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private let pageLimit = 8
    private var offset = 0
    private var searchAnime = ""
    
    var animeNetworkService: AnimeNetworkService = AnimeNetworkWebService()
    var favoriteService: FavoriteService = FavoriteWebService()
    var favorites: [Favorite] = []
    var animes: [AnimeNetwork] = [] {
        didSet {
            self.searchTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rechercher"
        self.searchTableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        self.animeNetworkService.getAnimes(completion: { animes in
            self.animes.append(contentsOf: animes)
        }, pageLimit: String(self.pageLimit), offset: String(self.offset), mySearch: searchAnime)
        
        self.favoriteService.getFavoritesByIdUser{ favorites in
            self.favorites = favorites
        }
        
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        let isFavorite = getIsFavorite(favorites: self.favorites, idAnime: animes[indexPath.row].id)
        let idFavorite = getIdFavorite(favorites: self.favorites, idAnime: animes[indexPath.row].id)
        
        cell.idFavorite = idFavorite
        cell.configure(with: animes[indexPath.row], isFavorite: isFavorite)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeDetail = AnimeDetailViewController()
        
        let anime = animes[indexPath.row]
        
        let isFavorite = getIsFavorite(favorites: self.favorites, idAnime: anime.id)
        let idFavorite = getIdFavorite(favorites: self.favorites, idAnime: anime.id)
        
        animeDetail.idFavorite = idFavorite
        animeDetail.isFavorite = isFavorite
        animeDetail.anime = anime
       
        self.navigationController?.pushViewController(animeDetail, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let lastIndex = self.animes.count - 1
        self.offset += self.animes.count
        
        if indexPath.row == lastIndex {
            self.animeNetworkService.getAnimes(completion: { animes in
                self.animes.append(contentsOf: animes)
            }, pageLimit: String(self.pageLimit), offset: String(self.offset), mySearch: self.searchAnime)
            
            self.searchTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        self.searchAnime = searchBar.text!
        self.offset = 0
        
        if(searchBar.text == ""){
        } else{
            self.animeNetworkService.getAnimes(completion: { animes in
                self.animes = animes
            }, pageLimit: String(self.pageLimit), offset: String(self.offset), mySearch: "&filter[text]='\(self.searchAnime)'")
        }
    }
    
    func getIsFavorite(favorites: [Favorite], idAnime: String) -> Bool {
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return false
        }
        
        for favorite in favorites {
            if favorite.idUser == Int(idUser) && favorite.idAnime == idAnime {
                return true
            }
        }
        return false
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
