//
//  ChanelDetailTableViewCell.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 24/07/2022.
//

import UIKit

class ChanelDetailTableViewCell: UITableViewCell {

    static let identifier = "ChanelDetailTableViewCell"
        
    static func nib() -> UINib {
        return UINib(nibName: "ChanelDetailTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var headerComment: UIView!
    @IBOutlet weak var comment: UIView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UILabel!
    
    var model: Comment!
    
    public func configure(with model: Comment){
        self.model = model
        
        self.setColorView()
        self.setUsername()
        self.setDate()
        self.setContent()
    }
    
    private func setUsername(){
        self.username.text = model.username
    }
    
    private func setDate(){
        self.date.text = model.createDate
    }
    
    private func setContent(){
        self.content.text = model.content
    }
    
    private func setColorView(){
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        if model.idUser == Int(idUser) {
            self.headerComment.backgroundColor = UIColor.systemGreen
            self.comment.backgroundColor = UIColor.systemGreen
        } else {
            self.headerComment.backgroundColor = UIColor.systemGray
            self.comment.backgroundColor = UIColor.systemGray
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerComment.layer.cornerRadius = 20
        comment.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
