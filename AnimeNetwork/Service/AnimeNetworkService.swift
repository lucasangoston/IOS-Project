//
//  AnimeNetworkService.swift
//  AnimeNetwork
//
//  Created by Lucas Angoston on 30/06/2022.
//

import Foundation


protocol AnimeNetworkService{
    func getAnimesByTrending(completion: @escaping ([AnimeNetwork]) -> Void)
    
    func getAnimes(completion: @escaping ([AnimeNetwork]) -> Void, pageLimit: String, offset: String, mySearch: String)
}
