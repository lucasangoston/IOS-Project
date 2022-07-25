//
//  ChanelService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 19/07/2022.
//

import Foundation

protocol ChanelService{
    func getChanels(completion: @escaping ([Chanel]) -> Void)
}
