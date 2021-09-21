//
//  UserType.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import Foundation

enum UserType: Int {
    case musician = 1
    case company = 2

    var description: String {
        switch self {
        case .musician:
            return "Músico"
        case .company:
            return "Contratante"
        }
    }
}
