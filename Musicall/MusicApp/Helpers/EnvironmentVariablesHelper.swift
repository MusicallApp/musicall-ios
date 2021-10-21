//
//  EnvironmentVariablesHelper.swift
//  Musicall
//
//  Created by Lucas Oliveira on 21/10/21.
//

import Foundation
class EnvironmentVariablesHelper {
    static func read(_ name: String) -> String? {
        let environment = ProcessInfo.processInfo.environment
        var value = environment[name]
        if value == nil {
            do {
                value = try String(contentsOfFile: name, encoding: String.Encoding.utf8)
            } catch {
            }
        }
        if let value = value {
            return value
        }
        return nil
    }

}
