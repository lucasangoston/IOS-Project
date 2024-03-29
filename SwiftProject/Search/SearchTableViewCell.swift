//
//  SearchTableViewCell.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeFavorite: UIButton!
    @IBOutlet weak var animeDate: UILabel!
    @IBOutlet weak var animeDescription: UILabel!
    
    var isFavorite: Bool!
    var favoriteService: FavoriteService = FavoriteWebService()
    var model: AnimeNetwork!
    var idFavorite: Int!
    
    static let identifier = "SearchTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with model: AnimeNetwork, isFavorite: Bool){
        self.model = model
        self.isFavorite = isFavorite
        
        self.setTitleAnime()
        self.setFavoriteButton()
        self.setDateAnime()
        self.setDescriptionAnime()
        
        let animeImageEncoded = setImageAnime(animeImageString: model.attributes.posterImage.original)
        
        self.animeImage.image = animeImageEncoded
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        self.animeImage.layer.masksToBounds = true
        self.animeImage.layer.cornerRadius = self.animeImage.frame.width/7.0
    }
    
    @IBAction func handleFavorite(){
        if  !self.isFavorite {
            self.animeFavorite.tintColor = UIColor.systemRed
            self.isFavorite = true
            self.favoriteService.createFavorite(idAnime: model.id)
        } else {
            self.animeFavorite.tintColor = UIColor.black
            self.isFavorite = false
            self.favoriteService.deleteFavorite(idFavorite: self.idFavorite)
        }
    }
    
    private func setTitleAnime(){
        self.animeTitle.text = model.attributes.canonicalTitle
        self.animeTitle.numberOfLines = 0
    }
    
    private func setDescriptionAnime(){
        self.animeDescription.text = self.truncateString(text: model.attributes.description)
        self.animeDescription.numberOfLines = 0
    }

    private func truncateString(text: String) -> String{
            return (text.count > 100) ? text.prefix(100) + "..." : text
    }
    
    private func setDateAnime(){
        self.animeDate.text = model.attributes.startDate
    }
    
    private func setImageAnime(animeImageString: String) -> UIImage{
        let url = URL(string: animeImageString)
        let data = try? Data(contentsOf: url!)
        
        let animeImage: UIImage
        
        if let imageData = data {
            animeImage = UIImage(data: imageData)!
        } else {
            let imageName = "not_found"
            guard let image = UIImage(named: imageName) else {
                return UIImage(named: "interrogation")!
            }
            animeImage = image
        }
        
        return animeImage
    }
    
    private func setFavoriteButton(){
        if self.isFavorite {
            self.animeFavorite.tintColor = UIColor.systemRed
        } else {
            self.animeFavorite.tintColor = UIColor.black
        }
    }
}

