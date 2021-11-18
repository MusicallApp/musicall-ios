//
//  ProfileModel.swift
//  Musicall
//
//  Created by Lucas Oliveira on 17/11/21.
//

import Foundation
import CloudKit

struct ProfileModel {
    let name: String
    let date: String
    let authorId: CKRecord.ID
}
