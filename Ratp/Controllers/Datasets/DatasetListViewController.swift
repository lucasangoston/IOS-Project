//
//  DatasetListViewController.swift
//  Ratp
//
//  Created by Benoit Briatte on 01/06/2022.
//

import UIKit

class DatasetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var datasetIndicatorView: UIActivityIndicatorView!
    var datasetService: RatpDatasetService = RatpDatasetWebService()
    var datasets: [RatpDataset] = [] {
        didSet {
            self.tableView.reloadData() // recharge la tableview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditTableView))
        // Si bundle == nil alors c'est votre projet :) eq. Bundle.main
        let cellNib = UINib(nibName: "DatasetTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "DATASET_CELL_ID")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.datasetIndicatorView.startAnimating()
        self.datasetService.fetchDatasets { datasets in
            self.datasetIndicatorView.stopAnimating()
            self.datasets = datasets
        }
    }
    
    @objc func handleEditTableView() {
        UIView.animate(withDuration: 0.66) {
            self.tableView.isEditing = !self.tableView.isEditing
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataset = self.datasets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DATASET_CELL_ID", for: indexPath) as! DatasetTableViewCell
        cell.setDataset(dataset)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Sup", message: "C'est votre dernier mot ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Oui JP", style: .destructive, handler: { _ in
            self.datasets.remove(at: indexPath.row)
        }))
        alertController.addAction(UIAlertAction(title: "Non", style: .cancel))
        self.present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let src = self.datasets.remove(at: sourceIndexPath.row)
        self.datasets.insert(src, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataset = self.datasets[indexPath.row]
        print(dataset.meta.title)
    }
    
    /**
     if let cell = tableView.dequeueReusableCell(withIdentifier: "DATASET_CELL_ID") {
         // REUTILISATION
         cell.textLabel?.text = "\(indexPath.row)"
         return cell
     } else {
         // CREATION
         let cell = UITableViewCell(style: .default, reuseIdentifier: "DATASET_CELL_ID")
         cell.textLabel?.text = "\(indexPath.row)"
         return cell
     }
     */
}
