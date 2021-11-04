//
//  PackageProviding.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 06/07/21.
//

import Foundation

// MARK: Protocol
public protocol BotProviderProtocol {
    var network: Networking { get }
    func sendMessage(_ telegramReport: TelegramReport, completion: @escaping (Swift.Result<TelegramResponse, Error>) -> Void)

}

// MARK: Implementation
public class BotProvider: BotProviderProtocol {

    public var network: Networking = Networking.shared

    let baseEndpoint: URLComponents = {
        var components = URLComponents()
        components.scheme = URLStructure.scheme.rawValue
        components.host = URLStructure.root.rawValue
        return components
    }()

    public init(network: Networking = Networking.shared) {
        self.network = network
    }

    public func sendMessage(_ telegramReport: TelegramReport, completion: @escaping (Swift.Result<TelegramResponse, Error>) -> Void) {
        var rootURL = self.baseEndpoint

        rootURL.path = URLStructure.pathBot.rawValue + EnvironmentVariables.botToken.getVariable() + URLStructure.pathSendMessage.rawValue

        let queryChatId = URLQueryItem(name: URLStructure.chatId.rawValue,
                                       value: EnvironmentVariables.chatId.getVariable())

        let queryText = URLQueryItem(name: URLStructure.text.rawValue,
                                     value: telegramReport.descriptionFormatted)

        let queryParseMode = URLQueryItem(name: URLStructure.parseMode.rawValue,
                                          value: ParseMode.markdown.rawValue)

        rootURL.queryItems = [queryChatId, queryText, queryParseMode]

        guard let url = rootURL.url else {return}

        network.get(url, completion: completion)
    }
}
