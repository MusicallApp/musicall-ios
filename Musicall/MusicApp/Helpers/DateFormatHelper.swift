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
    case pt_br
}

extension Date {
    func getFormattedDate(format: DateFormatHelper) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format.rawValue
        dateformat.locale = .init(identifier: Locale.pt_br.rawValue)
        return dateformat.string(from: self)
    }
}
