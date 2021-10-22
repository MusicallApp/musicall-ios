//
//  TelegramReport.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/10/21.
//

import Foundation

struct TelegramReport {
    let author: String
    let authorID: String
    let postID: String
    let message: String

    var descriptionFormatted: String {
        var message = "*Report Recebido ☹️* \n\n"
        message.append("*Author*: \(author) \n")
        message.append("*AuthorID*: \(authorID) \n")
        message.append("*RecordName*: \(postID) \n")
        message.append("*Message*: \(self.message) \n")
        return message
    }
}
