//
//  SearchViewController.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 04/07/2022.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private let pageLimit = 8
    private var offset = 0
    private var searchAnime = ""
    
    var animeNetworkService: AnimeNetworkService = AnimeNetworkWebService()
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
        
        cell.configure(with: animes[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeDetail = AnimeDetailViewController()
        
        let anime = animes[indexPath.row]
        
        
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
}
