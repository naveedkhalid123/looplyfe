//
//  ForgotPasswordViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 07/11/2025.
//

import Foundation
import FirebaseAuth

final class ForgotPasswordViewModel {
    let resetPassword = FirebaseAuth.shared
    
    public func resetPassword(email: String,  completion: @escaping(Result<Void, Error>) -> Void){
        resetPassword.resetPassword(email: email) { success, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}
