//
//  Comment.swift
//  Musicall
//
//  Created by Vitor Bryan on 16/09/21.
//

import Foundation
import CloudKit

class Comment {
    
    static let recordType = "Comment"
    var id = CKRecord.ID()
    let createdAt: Date
    let authorId: CKRecord.Reference
    let content: String
    let postId: CKRecord.Reference
    
    init?(record: CKRecord) {
        guard let createdAt = record["createdAt"] as? Date,
              let content = record["content"] as? String,
              let authorId = record["author_id"] as? CKRecord.Reference,
              let postId = record["post_id"] as? CKRecord.Reference else {
            return nil
        }
        
        id = record.recordID
        self.createdAt = createdAt
        self.authorId = authorId
        self.content = content
        self.postId = postId
        
    }
    
}
