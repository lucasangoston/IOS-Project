//
//  SearchTableViewCell.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 04/07/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    
    static let identifier = "SearchTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with anime: AnimeNetwork){
        self.animeTitle.text = anime.attributes.canonicalTitle
        self.animeTitle.numberOfLines = 0
        
        let animeImageEncoded = setImageAnime(animeImageString: anime.attributes.posterImage.original)
        
        self.animeImage.image = animeImageEncoded
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
