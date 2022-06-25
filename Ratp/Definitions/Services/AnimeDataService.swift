//
//  AnimeDatasetService.swift
//  ios_project
//
//  Created by Lucas Angoston on 25/06/2022.
//

import Foundation

protocol AnimeDataService {
    func fetchDatasets(completion: @escaping ([AnimeData]) -> Void) -> Void
}
