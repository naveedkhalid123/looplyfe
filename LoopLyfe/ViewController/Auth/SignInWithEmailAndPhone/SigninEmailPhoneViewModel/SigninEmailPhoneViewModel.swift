//
//  SigninEmailPhoneViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 30/10/2025.
//

import Foundation
import UIKit
import FirebaseAuth


var apiManager = APIManager()

var firebaseAuth = FirebaseAuth.shared

class SigninEmailPhoneViewModel {
    
    func validateEmail(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedEmail.isEmpty {
            Utility.shared.showToast(message: "Please enter your email address.")
            return false
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if !emailPred.evaluate(with: trimmedEmail) {
            Utility.shared.showToast(message: "Please enter a valid email address.")
            return false
        }
        return true
    }

    
    func isValidPhoneNumber(_ strPhone: String, region: String) -> Bool {
        do {
            _ = try Utility.shared.phoneNumberKit.parse(strPhone, withRegion: region, ignoreType: false)
            return false
        } catch {
            print("Phone number validation error: \(error)")
            return true
        }
    }
    
    
    func checkEmail(email: String, completion: @escaping(Result<Int, Error>) -> Void){
        
        let params: [String: Any] = [
            "email": email
        ]
        apiManager.checkEmail(parameters: params){ result in
            switch result {
            case .success(let code):
                completion(.success(code))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func signinUser(email: String, password: String , completion: @escaping(Result<AuthDataResult, Error>) -> Void){
        firebaseAuth.signIn(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                completion(.success(authResult))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
    
    func sendOTP(phone: String, completion: @escaping(Result<String, Error>) -> Void){
        firebaseAuth.verifyPhoneNumber(phoneNumber: phone) { verificationID, error in
            if let error = error {
                print("error",error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if let verificationID = verificationID {
                completion(.success(verificationID))
            }
        }
    }
    
    func verifyOTP(verificationID: String, otpCode: String, completion: @escaping(Result<String, Error>) -> Void) {
        firebaseAuth.createPhoneAuthCredential(verificationID: verificationID, verificationCode: otpCode) { result in
            switch result {
            case .success(let authResult):
                completion(.success(authResult.user.uid))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
    
    

