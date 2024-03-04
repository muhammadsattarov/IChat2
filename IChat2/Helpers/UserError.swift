//
//  UserError.swift
//  IChat2
//
//  Created by user on 27/02/24.
//

import Foundation

enum UserError {
    case notFilled
    case photoNoExist
    case cannotGetUserInfo
    case cannotUnwrapToUser
}


extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("There are empty rows. Fill in all the lines", comment: "")
        case .photoNoExist:
            return NSLocalizedString("The user did not select a photo", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Unable to download user data from Firebase", comment: "")
        case .cannotUnwrapToUser:
            return NSLocalizedString("Unable to convert MUser is User", comment: "")
        }
    }
}


