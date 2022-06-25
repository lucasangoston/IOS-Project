//
//  HomeViewController.swift
//  ios_project
//
//  Created by Lucas Angoston on 25/06/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var dataService: AnimeDataService = AnimeDataWebService()
    var data: [AnimeData] = [] {
        didSet {
            self.tableView.reloadData() // recharge la tableview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditTableView))
        // Si bundle == nil alors c'est votre projet :) eq. Bundle.main
        let cellNib = UINib(nibName: "HomeTableViewController", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "DATA_CELL_ID")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //self.datasetIndicatorView.startAnimating()
        self.dataService.fetchDatasets { data in
            //self.datasetIndicatorView.stopAnimating()
            self.data = data
        }
    }
    
    @objc func handleEditTableView() {
        UIView.animate(withDuration: 0.66) {
            self.tableView.isEditing = !self.tableView.isEditing
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DATA_CELL_ID", for: indexPath) as! HomeTableViewCell
        cell.setData(data)
        return cell
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
