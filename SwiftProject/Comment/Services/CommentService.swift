//
//  CommentService.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 24/07/2022.
//

import Foundation

protocol CommentService {
    func getCommentsByIdChanel(completion: @escaping ([Comment]) -> Void, idChanel: Int)
    
    func createComment(idChanel: Int, content: String)
    
    func deleteComment(idComment: Int)
}
