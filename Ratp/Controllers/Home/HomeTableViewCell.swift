//
//  HomeTableViewCell.swift
//  ios_project
//
//  Created by Lucas Angoston on 25/06/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet var canonicalTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ data: AnimeData) {
        self.canonicalTitle.text = data.attributes.canonicalTitle
    }
    
}
