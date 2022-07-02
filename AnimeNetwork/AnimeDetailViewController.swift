//
//  AnimeDetailViewController.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 02/07/2022.
//

import UIKit

class AnimeDetailViewController: UIViewController {
    
    //@IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeCover: UIImageView!
    
    var anime: AnimeNetwork!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAnimeDetail()

        // Do any additional setup after loading the view.
    }
    
    private func setAnimeDetail(){
        //animeTitle.text = self.anime.attributes.canonicalTitle
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
