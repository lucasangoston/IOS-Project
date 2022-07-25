//
//  ChanelService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

protocol ChanelService{
    func getChanels(completion: @escaping ([Chanel]) -> Void)
    
    func getChanelsByIdUser(completion: @escaping ([UserChanel]) -> Void)
    
    func joinChanel(idChanel: Int)
    
    func quitChanel(idChanel: Int)
    
    func createChanel(chanelName: String, chanelDescription: String, chanelTheme: String)
}
