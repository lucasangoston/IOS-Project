//
//  ChanelTableViewCell.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 21/07/2022.
//

import UIKit

class ChanelTableViewCell: UITableViewCell {

    static let identifier = "chanelTableViewCell"
        
    static func nib() -> UINib {
        return UINib(nibName: "ChanelTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var chanelView: UIView!
    @IBOutlet weak var topChanelView: UIView!
    @IBOutlet weak var chanelName: UILabel!
    @IBOutlet weak var chanelTheme: UIButton!
    @IBOutlet weak var chanelDescription: UILabel!
    
    var model: Chanel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chanelView.layer.cornerRadius = 20
        topChanelView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none

        // Configure the view for the selected state
    }
    
    public func configure(with model: Chanel){
        self.model = model
        
        self.setChanelName()
        self.setChanelTheme()
        self.setChanelDescription()
    }
    
    private func setChanelName(){
        self.chanelName.text = model.chanelName
    }
    
    private func setChanelTheme(){
        var config = UIButton.Configuration.tinted()
        config.subtitle = model.theme
        
        self.chanelTheme.configuration = config
    }
    
    private func setChanelDescription(){
        self.chanelDescription.text = model.description
    }
}
