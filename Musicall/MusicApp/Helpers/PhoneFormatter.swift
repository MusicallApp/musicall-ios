//
//  PhoneFormatter.swift
//  Musicall
//
//  Created by Elias Ferreira on 05/10/21.
//

import UIKit

public protocol InputMaskProtocol {
    func formattedString(from plainString: String) -> String
    func mask(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool
}

public class PhoneFormatter: InputMaskProtocol {

    // MARK: Properties

    private var pattern: String
    private let digit: Character = "#"

    // MARK: Lifecycle

    public init(pattern: String = "(##) #####-####") {
        self.pattern = pattern
    }

    // MARK: - Functions.

    public func formattedString(from plainString: String) -> String {
        guard !pattern.isEmpty else { return plainString }

        let pattern: [Character] = Array(self.pattern)
        let allowedCharachters = CharacterSet.alphanumerics
        let filteredInput = String(plainString.unicodeScalars.filter(allowedCharachters.contains))
        let input: [Character] = Array(filteredInput)
        var formatted: [Character] = []

        var patternIndex = 0
        var inputIndex = 0

        loop: while inputIndex < input.count {
            let inputCharacter = input[inputIndex]
            let allowed: CharacterSet

            guard patternIndex < pattern.count else { break loop }

            switch pattern[patternIndex] {
            case digit:
                allowed = .decimalDigits
            default:
                formatted.append(pattern[patternIndex])
                patternIndex += 1
                continue loop
            }

            guard inputCharacter.unicodeScalars.allSatisfy(allowed.contains) else {
                inputIndex += 1
                continue loop
            }

            formatted.append(inputCharacter)
            patternIndex += 1
            inputIndex += 1
        }

        return String(formatted)
    }

    public func mask(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
        let string = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let formatted = formattedString(from: string)
        textField.text = formatted
        return formatted.isEmpty
    }
}
