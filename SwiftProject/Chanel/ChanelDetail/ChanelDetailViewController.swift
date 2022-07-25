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
    var chanelService: ChanelService = ChanelWebService()
    var isJoined: Bool!
    var chanel: Chanel!
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewComment.separatorColor = UIColor.white;

        self.setChanelDetail()
        self.chanelJoinButton.layer.cornerRadius = 8.0
        
        self.tableViewComment.register(ChanelDetailTableViewCell.nib(), forCellReuseIdentifier: ChanelDetailTableViewCell.identifier)
        
        self.setchanelJoinButton()
        
        self.commentService.getCommentsByIdChanel(completion: { comments in
            self.comments = comments
        }, idChanel: chanel.idChanel)
        
        self.tableViewComment.delegate = self
        self.tableViewComment.dataSource = self
        
        self.tableViewComment.refreshControl = myRefreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl){
        comments.removeAll()
        
        self.commentService.getCommentsByIdChanel(completion: { comments in
            self.comments = comments
        }, idChanel: chanel.idChanel)
        
        self.tableViewComment.reloadData()
        sender.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let comment = comments[indexPath.row]
              
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        if Int(idUser) == comment.idUser {
            self.commentService.deleteComment(idComment: comment.idComment)
        } else {
            let alert = UIAlertController(title: "Heu..", message: "vous essayez de supprimer un commentaire que vous n'avez pas écris.. La liberté d'expression est importe sur ce serveur", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChanelDetailTableViewCell.identifier, for: indexPath) as! ChanelDetailTableViewCell
        
        cell.configure(with: comments[indexPath.row])
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        comments.removeAll()
        
        self.commentService.getCommentsByIdChanel(completion: { comments in
            self.comments = comments
        }, idChanel: chanel.idChanel)
        
        self.tableViewComment.reloadData()
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
        
        if self.isJoined {
            if content.isEmpty || self.contentComment.textColor == UIColor.lightGray {
                    let alert = UIAlertController(title: "Vous n'avez pas de contenu à partager", message: "Raconter ce qui vous passe par la tête !", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
            } else {
                print(chanel.idChanel)
                commentService.createComment(idChanel: chanel.idChanel, content: content)
            }
        } else {
            let usernameCurentUser = UserDefaults.standard.string(forKey: "username")
            
            guard let username = usernameCurentUser else {
                return
            }
            let alert = UIAlertController(title: "Salut \(username) !", message: "Tu dois d'abord rejoindre le serveur si tu souhaite partager avec la communauté.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setChanelDetail(){
        self.chanelName.text = self.chanel.chanelName
        self.chanelName.numberOfLines = 0
        self.chanelName.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
    }
    
    private func setchanelJoinButton(){
        if self.isJoined {
            var config = UIButton.Configuration.tinted()
            config.subtitle = NSLocalizedString("chanelDetail.joined", comment: "")
            self.chanelJoinButton.configuration = config
        } else {
            var config = UIButton.Configuration.tinted()
            config.subtitle = NSLocalizedString("chanelDetail.join", comment: "")
            self.chanelJoinButton.configuration = config
        }
    }
    
    @IBAction func handleJoinChanel(){
        if  !self.isJoined {
            self.setchanelJoinButton()
            self.isJoined = true
            self.chanelService.joinChanel(idChanel: chanel.idChanel)
        } else {
            self.setchanelJoinButton()
            self.isJoined = false
            self.chanelService.quitChanel(idChanel: chanel.idChanel)
        }
    }
}
