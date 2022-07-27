//
//  FavoriteListTableViewCell.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 23/07/2022.
//

import UIKit

class FavoriteListTableViewCell: UITableViewCell {

    static let identifier = "FavoriteListTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "FavoriteListTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var animePicture: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var favoriteView: UIView!
    
    var model: AnimeNetwork!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        self.animePicture.layer.masksToBounds = true
        self.animePicture.layer.cornerRadius = self.animePicture.frame.width/7.0
    
        // Configure the view for the selected state
    }
    
    public func configure(with model: AnimeNetwork){
        self.model = model
        
        self.setAnimeTitle()
        self.setAnimePicture()
    }
    
    private func setAnimeTitle(){
        self.animeTitle.numberOfLines = 0
        self.animeTitle.text = self.model.attributes.canonicalTitle
    }
    
    private func setAnimePicture(){
        let animeImageEncoded = setImageAnime(animeImageString: self.model.attributes.posterImage.original)
        
        animePicture.image = animeImageEncoded
        animePicture.contentMode = .scaleAspectFill
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
