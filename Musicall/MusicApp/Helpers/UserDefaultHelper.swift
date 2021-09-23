//
//  UserDefaultHelper.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

enum Field: String {
    case userNickName = "MC_USER_NICKNAME"
    case userCellphone = "MC_USER_CELLPHONE"
    case userType = "MC_USER_TYPE"
}

class UserDefaultHelper {
    static func set(_ value: Any, for field: Field) {
        UserDefaults.standard.setValue(value, forKey: field.rawValue)
    }

    static func get(field: Field) -> Any? {
        switch field {
        case .userType:
            return UserDefaults.standard.value(forKey: field.rawValue) as? Int
        default:
            return UserDefaults.standard.value(forKey: field.rawValue) as? String
        }
    }

    static func setUser(_ user: User?) {
        if let nickName = user?.nickName,
           let phoneNumber = user?.phoneNumber {
            set(nickName, for: .userNickName)
            set(phoneNumber, for: .userCellphone)
        }
    }

    static func getUser() -> User? {
        if let nickname = get(field: .userNickName) as? String,
           let phoneNumber = get(field: .userCellphone) as? String,
           let type = UserType.init(rawValue: get(field: .userType) as? Int ?? 1) {
            return User(nickName: nickname, phoneNumber: phoneNumber, type: type)
        } else {
            return nil
        }
    }
}
