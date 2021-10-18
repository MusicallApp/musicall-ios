//
//  PlistHelper.swift
//  Musicall
//
//  Created by Lucas Oliveira on 14/10/21.
//

import Foundation

class PlistHelper {
    func read(key: String) -> Any? {
        var config: [String: Any]?

        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)

                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }

        return config?[key] ?? nil
    }
}
