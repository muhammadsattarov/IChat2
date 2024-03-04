//
//  Validators.swift
//  IChat2
//
//  Created by user on 27/02/24.
//

import Foundation


class Validators {
    
    static func isFilled(email: String?, passwprd: String?, confirmPassword: String?) -> Bool {
        guard let email = email,
              let passwprd = passwprd,
              let confirmPassword = confirmPassword,
              email != "",
              passwprd != "",
              confirmPassword != ""
        else {
            return false
        }
        return true
    }
    
    static func isFilled(username: String?, description: String?, gender: String?) -> Bool {
        guard let username = username,
              let description = description,
              let gender = gender,
              username != "",
              description != "",
              gender != ""
        else {
            return false
        }
        return true
    }

    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
 
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}

