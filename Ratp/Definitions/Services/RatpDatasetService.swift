//
//  DatasetService.swift
//  Ratp
//
//  Created by Benoit Briatte on 01/06/2022.
//

import Foundation

// EQ interface au sens programmation --> contrat a respecter
protocol RatpDatasetService {
    func fetchDatasets(completion: @escaping ([RatpDataset]) -> Void) -> Void
}
