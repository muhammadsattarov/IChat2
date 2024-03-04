//
//  AuthError.swift
//  IChat2
//
//  Created by user on 27/02/24.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("There are empty rows. Fill in all the lines", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Mail format is not valid", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("Passwords do not matched", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("server error", comment: "")
        }
    }
}

