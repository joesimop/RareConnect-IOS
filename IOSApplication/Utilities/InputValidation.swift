//
//  InputValidation.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/24/24.
//

import Foundation

///Function to validate email
func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

    do {
        let regex = try NSRegularExpression(pattern: emailRegex)
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    } catch {
        return false
    }
}

///Makes sure password is valid
func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = "^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$"
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return passwordTest.evaluate(with: password)
}
