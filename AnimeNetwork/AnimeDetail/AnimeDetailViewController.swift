//
//  AnimeDetailViewController.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 02/07/2022.
//

import UIKit

class AnimeDetailViewController: UIViewController {
   
    @IBOutlet weak var animeCover: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeSynopsis: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var anime: AnimeNetwork!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAnimeDetail()

        // Do any additional setup after loading the view.
    }
    
    private func setAnimeDetail(){
        
        animeTitle.text = self.anime.attributes.canonicalTitle
        animeSynopsis.text = self.anime.attributes.synopsis
        animeSynopsis.numberOfLines = 0
        
        let animeImageEncoded = setImageAnime(animeImageString: self.anime.attributes.coverImage.tiny)
        
        animeCover.image = animeImageEncoded
        animeCover.contentMode = .scaleAspectFill
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
