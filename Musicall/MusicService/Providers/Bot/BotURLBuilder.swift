//
//  BotURLBuilder.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/10/21.
//

import Foundation

enum URLStructure: String {
    case scheme = "https"
    case root = "api.telegram.org"
    case pathBot = "/bot"
    case pathSendMessage = "/sendMessage"
    case chatId = "chat_id"
    case text
    case parseMode = "parse_mode"
}

enum ParseMode: String, Codable {
    case html = "HTML"
    case markdown = "MarkDown"
    case markdownv2 = "MarkdownV2"
}

enum EnvironmentVariables: String {
    case botToken = "MUSICALLAPP_TELEGRAM_BOT_TOKEN"
    case chatId = "TELEGRAM_CHAT_ID"

    func getVariable() -> String {
        guard let message = Bundle.main.infoDictionary?[self.rawValue] as? String else {
            assertionFailure(ErrorHelper.botInvalidCredentials.rawValue)
            return ""
        }

        return message
    }
}
