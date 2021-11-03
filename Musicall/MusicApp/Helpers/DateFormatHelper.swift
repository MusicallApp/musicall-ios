//
//  DateFormatHelper.swift
//  Musicall
//
//  Created by Lucas Oliveira on 30/09/21.
//

import Foundation

enum DateFormatHelper: String {
    case dayMonth = "dd 'de' MMMM"
}

enum Locale: String {
    case ptbr = "pt_BR"
}

extension Date {
    func getFormattedDate(format: DateFormatHelper) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format.rawValue
        dateformat.locale = .init(identifier: Locale.ptbr.rawValue)
        return dateformat.string(from: self)
    }
}
