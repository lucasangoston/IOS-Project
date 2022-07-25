//
//  AnimeNetworkService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

protocol AnimeNetworkService{
    func getAnimesByTrending(completion: @escaping ([AnimeNetwork]) -> Void)
    
    func getAnimes(completion: @escaping ([AnimeNetwork]) -> Void, pageLimit: String, offset: String, mySearch: String)
}
