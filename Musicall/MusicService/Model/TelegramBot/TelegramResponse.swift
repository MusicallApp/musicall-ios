//
//  TelegramResponse.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/10/21.
//

import Foundation

    // MARK: - Welcome
public struct TelegramResponse: Codable {
    let ok: Bool
    let result: Result
}

    // MARK: - Result
public struct Result: Codable {
    let messageID: Int
    let from: From
    let chat: Chat
    let date: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case messageID = "message_id"
        case from, chat, date, text
    }
}

    // MARK: - Chat
public struct Chat: Codable {
    let id: Int
    let title, type: String
    let allMembersAreAdministrators: Bool

    enum CodingKeys: String, CodingKey {
        case id, title, type
        case allMembersAreAdministrators = "all_members_are_administrators"
    }
}

    // MARK: - From
public struct From: Codable {
    let id: Int
    let isBot: Bool
    let firstName, username: String

    enum CodingKeys: String, CodingKey {
        case id
        case isBot = "is_bot"
        case firstName = "first_name"
        case username
    }
}
