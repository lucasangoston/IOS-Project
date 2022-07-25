//
//  ProfileTableViewCell.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 25/07/2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    var model: Chanel!
    
    static let identifier = "ProfileTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func configure(with model: Chanel, isFavorite: Bool){
        
    }
}
