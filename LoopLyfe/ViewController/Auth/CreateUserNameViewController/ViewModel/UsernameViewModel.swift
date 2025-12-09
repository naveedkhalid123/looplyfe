//
//  UsernameViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 06/11/2025.
//

import Foundation
import UIKit

final class UsernameViewModel {
    
    private let apiManager = APIManager()
    
    let firebase = FirebaseAuth.shared
    let signinViewModel = SigninViewModel()
    
    private lazy var loader: UIView = {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow })
        else {
            fatalError("Unable to access key window")
        }
        return Utility.shared.createActivityIndicator(keyWindow)
    }()
    
    
    func checkUsername(username: String, completion: @escaping (Result<Int, Error>) -> Void) {
        let params: [String: Any] = [
            "username": username
        ]
        self.loader.isHidden = false
        
        apiManager.checkUsername(parameters: params) { result in
            self.loader.isHidden = true
            switch result {
            case .success(let code):
                completion(.success(code))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func isValidUsername(_ username: String) -> Bool {
        // Allowed: letters, numbers, underscore, dot — 3 to 20 chars
        let usernameRegex = "^[A-Za-z0-9._]{3,20}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }
    
    
    func createUser(email: String, password: String, social: String, username: String,completion: @escaping (Result<Int, Error>) -> Void) {
        self.loader.isHidden = false
        firebase.createUser(email: email, password: password) { user, error in
            if let error = error {
                self.loader.isHidden = true
                Utility.shared.showToast(message: error.localizedDescription)
                completion(.failure(error))
                return
            }
         
            if let uid = user {
                UserDefaultsManager.shared.authToken = uid
                self.signinViewModel.registerUser(social: social, username: username, firstName: username, lastName: username) { result in
                    self.loader.isHidden = true
                    switch result {
                    case .success(let status):
                        UserDefaultsManager.shared.authToken = ""
                        completion(.success(status))
                        
                    case .failure(let error):
                        Utility.shared.showToast(message: error.localizedDescription)
                        completion(.failure(error))
                    }
                }
                
            }
        }
    }

}
