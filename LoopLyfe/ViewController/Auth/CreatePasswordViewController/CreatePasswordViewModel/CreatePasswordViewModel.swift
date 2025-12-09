//
//  CreatePasswordViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 30/10/2025.
//


import Foundation

final class CreatePasswordViewModel {

    func isValidLength(_ password: String) -> Bool {
        return password.count >= 8 && password.count <= 20
    }
    
    func isValidContent(_ password: String) -> Bool {
        let pattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>]).+$"
        return password.range(of: pattern, options: .regularExpression) != nil
    }
    func isValidPassword(_ password: String) -> Bool {
        return isValidLength(password) && isValidContent(password)
    }
}
