//
//  HomeViewController.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 30/06/2022.
//

import UIKit
import WebKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var animeNetworkService: AnimeNetworkService = AnimeNetworkWebService()
    var animes: [AnimeNetwork] = [] {
        didSet {
            self.tableView.reloadData() // recharge la tableview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "HOME_CELL")
        self.animeNetworkService.getAnimesByTrending { animes in
            self.animes = animes
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HOME_CELL", for: indexPath) as! HomeTableViewCell
        
        let message = self.animes[indexPath.row].attributes.posterImage.tiny
        
        let url = URL(string: message)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            cell.animeImage.image = UIImage(data: imageData)
        }

        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.animes[indexPath.row])
    }
    
    func getImage( _ uS:String, iV: UIImageView){
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImage {

    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}
