//
//  Comment.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 24/07/2022.
//

import Foundation

class Comment {
    let idComment: Int
    let idChanel: Int
    let idUser: Int
    let username: String
    let content: String
    let createDate: String
    
    internal init(idComment: Int, idChanel: Int, idUser: Int, username: String, content: String, createDate: String) {
        self.idComment = idComment
        self.idChanel = idChanel
        self.idUser = idUser
        self.username = username
        self.content = content
        self.createDate = createDate
    }
    
    convenience init?(dict: [String: Any]) {
        guard let idComment = dict["_idComment"] as? Int,
              let idChanel = dict["_idChanel"] as? Int,
              let idUser = dict["_idUser"] as? Int,
              let username = dict["_username"] as? String,
              let content = dict["_content"] as? String,
              let createDate = dict["_createDate"] as? String else {
            return nil
        }
      
        self.init(idComment: idComment, idChanel: idChanel, idUser: idUser, username: username, content: content, createDate: createDate)
    }
}
