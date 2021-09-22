//
//  Model.swift
//  Musicall
//
//  Created by Vitor Bryan on 15/09/21.
//

import Foundation
import CloudKit

class Post {
    
    static let recordType = "Post"
    var id = CKRecord.ID()
    let createdAt: Date
    let authorId: CKRecord.Reference
    let content: String
    let comment: [CKRecord.Reference]?
    let likes: Int
    
    init?(record: CKRecord) {
        guard
            let createdAt = record["createdAt"] as? Date,
              let content = record["content"] as? String,
              let likes = record["likes"] as? Int,
              let authorId = record["author_id"] as? CKRecord.Reference,
              let comment = record["comments"] as? [CKRecord.Reference]? else {
            return nil
        }
        
        id = record.recordID
        self.createdAt = createdAt
        self.authorId = authorId
        self.content = content
        self.comment = comment
        self.likes = likes
        
    }
}
