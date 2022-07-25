//
//  ChanelDetailViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import UIKit

class ChanelDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chanelName: UILabel!
    @IBOutlet weak var chanelDescription: UIButton!
    @IBOutlet weak var chanelJoinButton: UIButton!
    @IBOutlet weak var contentComment: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var tableViewComment: UITableView!
    
    var comments: [Comment] = [] {
        didSet {
            self.tableViewComment.reloadData() // recharge la tableview
        }
    }
    var commentService: CommentService = CommentWebService()
    var chanel: Chanel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewComment.separatorColor = UIColor.white;

        self.setChanelDetail()
        
        self.tableViewComment.register(ChanelDetailTableViewCell.nib(), forCellReuseIdentifier: ChanelDetailTableViewCell.identifier)
        
        self.commentService.getCommentsByIdChanel(completion: { comments in
            self.comments = comments
        }, idChanel: chanel.idChanel)
        
        self.tableViewComment.delegate = self
        self.tableViewComment.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChanelDetailTableViewCell.identifier, for: indexPath) as! ChanelDetailTableViewCell
        
        cell.configure(with: comments[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    @IBAction func getDescription(){
        let alert = UIAlertController(title: "Description", message: chanel.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitComment(){
        guard let content  = self.contentComment.text else {
            return
        }
        
        if content.isEmpty || self.contentComment.textColor == UIColor.lightGray {
                let alert = UIAlertController(title: "Vous n'avez pas de contenu à partager", message: "Raconter ce qui vous passe par la tête !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
        } else {
            commentService.createComment(idChanel: chanel.idChanel, content: content)
        }
    }
    
    private func setChanelDetail(){
        self.chanelName.text = self.chanel.chanelName
        self.chanelName.numberOfLines = 0
        self.chanelName.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
    }
    
    
}
