//
//  AnimeDetailViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import UIKit

class AnimeDetailViewController: UIViewController {
   
    @IBOutlet weak var animeCover: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeSynopsis: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var animeFavorite: UIButton!
    
    var anime: AnimeNetwork!
    var isFavorite: Bool!
    var idFavorite: Int!
    var favoriteService: FavoriteService = FavoriteWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAnimeDetail()
        self.setFavoriteButton()
    }
    
    private func setAnimeDetail(){
        
        animeTitle.text = self.anime.attributes.canonicalTitle
        animeSynopsis.text = self.anime.attributes.synopsis
        animeSynopsis.numberOfLines = 0
        
        let animeImageEncoded = setImageAnime(animeImageString: self.anime.attributes.coverImage.tiny)
        
        animeCover.image = animeImageEncoded
        animeCover.contentMode = .scaleAspectFill
    }
    
    @IBAction func handleFavoriteAnimeDetail(){
        if  !self.isFavorite {
            self.animeFavorite.tintColor = UIColor.systemRed
            self.isFavorite = true
            self.favoriteService.createFavorite(idAnime: anime.id)
        } else {
            self.animeFavorite.tintColor = UIColor.black
            self.isFavorite = false
            self.favoriteService.deleteFavorite(idFavorite: self.idFavorite)
        }
    }
    
    private func setFavoriteButton(){
        if self.isFavorite {
            self.animeFavorite.tintColor = UIColor.systemRed
        } else {
            self.animeFavorite.tintColor = UIColor.black
        }
    }
    
    private func setImageAnime(animeImageString: String) -> UIImage{
        let url = URL(string: animeImageString)
        let data = try? Data(contentsOf: url!)
        
        let animeImage: UIImage
        
        if let imageData = data {
            animeImage = UIImage(data: imageData)!
        } else {
            let imageName = "not_found"
            let image = UIImage(named: imageName)
            animeImage = image!
        }
        
        return animeImage
    }
}

