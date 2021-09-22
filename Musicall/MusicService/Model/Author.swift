//
//  AuthorModel.swift
//  Musicall
//
//  Created by Vitor Bryan on 16/09/21.
//

import Foundation
import CloudKit

class Author {
    
    static let recordType = "Author"
    var id = CKRecord.ID()
    let createdAt: Date
    let nickname: String
    let number: String
    let posts: [CKRecord.Reference]?
    let type: Int
    
    init?(record: CKRecord) {
        guard let createdAt = record["createdAt"] as? Date,
              let nickname = record["nickname"] as? String,
              let number = record["number"] as? String,
              let type = record["type"] as? Int,
              let posts = record["posts"] as? [CKRecord.Reference]? else {
            return nil
        }
        id = record.recordID
        self.createdAt = createdAt
        self.nickname = nickname
        self.number = number
        self.type = type
        self.posts = posts
    }
}
