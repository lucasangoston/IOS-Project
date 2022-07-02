//
//  HomeCollectionViewCell.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 01/07/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    
    static let identifier = "HomeCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
    
    var models = [AnimeNetwork]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model: AnimeNetwork){
        self.animeTitle.text = model.attributes.canonicalTitle
        
        let animeImageEncoded = setImageAnime(animeImageString: model.attributes.posterImage.original)
        
        self.animeImage.image = animeImageEncoded
        self.animeImage.contentMode = .scaleToFill
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
