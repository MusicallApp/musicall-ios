//
//  Report.swift
//  Musicall
//
//  Created by Elias Ferreira on 22/10/21.
//

import Foundation
import CloudKit

struct Report {
    var authorName: String
    var authorId: CKRecord.ID
    var postId: CKRecord.ID
}
