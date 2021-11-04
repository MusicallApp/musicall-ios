//
//  UserDefaultHelper.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit
import CloudKit

enum Field: String {
    case userNickName = "MC_USER_NICKNAME"
    case userCellphone = "MC_USER_CELLPHONE"
    case userType = "MC_USER_TYPE"
    case userID = "MC_USER_ID"
    case blockedUsers = "MC_BLOCKED_USERS"
}

class UserDefaultHelper {
    static func set(_ value: Any, for field: Field) {
        UserDefaults.standard.setValue(value, forKey: field.rawValue)
    }

    static func get(field: Field) -> Any? {
        switch field {
        case .userType:
            return UserDefaults.standard.value(forKey: field.rawValue) as? Int
        case .userID:
            if let recordName = UserDefaults.standard.value(forKey: field.rawValue) as? String {
                return CKRecord.ID(recordName: recordName)
            }
            return CKRecord.ID(recordName: "")
        case .blockedUsers:
            var blockedUsers = [CKRecord.ID]()
            if let recordName = UserDefaults.standard.value(forKey: field.rawValue) as? [String] {
                recordName.forEach { name in
                    blockedUsers.append(CKRecord.ID(recordName: name))
                }
            }
            return blockedUsers
        default:
            return UserDefaults.standard.value(forKey: field.rawValue) as? String
        }
    }

    static func setBlockedUsers(users: [CKRecord.ID]?) {
        var names = [String]()
        users?.forEach { recordId in
            names.append(recordId.recordName)
        }
        set(names, for: .blockedUsers)
    }

    static func setUser(_ user: User) {
        set(user.nickName, for: .userNickName)
        set(user.phoneNumber, for: .userCellphone)
        set(user.type.rawValue, for: .userType)
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
