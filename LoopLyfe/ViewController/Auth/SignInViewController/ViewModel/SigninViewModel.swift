//
//  SigninViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 30/10/2025.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

final class SigninViewModel {
    
    private let apiManager = APIManager()
    
    
    // MARK: - Fetch User Detail
    func showUserDetail(completion: @escaping (Result<ShowUserDetailModel, Error>) -> Void) {
        apiManager.showUserDetailWithT { result in
            switch result {
            case .success(let status):
                completion(.success(status))
            case .failure(let error):
                print("User Detail Error:", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    
    func registerUser(social: String, username: String , firstName: String, lastName: String, email: String = "" ,completion: @escaping (Result<Int, Error>) -> Void) {
        let param: [String : Any] =
        [
            "dob": "",
            "username": username,
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "phone": "",
            "social_id": "",
            "auth_token": UserDefaultsManager.shared.authToken,
            "device_token": UserDefaultsManager.shared.deviceToken,
            "social": social
        ]

        apiManager.registerUser(parameters: param) { result in
            switch result {
            case .success(let status):
                completion(.success(status))
            case .failure(let error):
                print("User Detail Error:", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func signinWithApple(idTokenString: String, nonce: String, completion: @escaping (Result<ShowUserDetailModel, Error>) -> Void){
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = authResult?.user else { return }
            
            // Save Firebase UID
            UserDefaultsManager.shared.authToken = user.uid
            print("Signed in with UID:", user.uid)
            
            // Check if User Exists
            self.showUserDetail { result in
                completion(result)
            }
        }
    }
    
    
    // MARK: - Google Sign-In
    func signinWithGoogle(from viewController: UIViewController, completion: @escaping (Result<[String: String], Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            
            if let error = error {
                print("Google Sign-In Error:", error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let result = signInResult,
                  let idToken = result.user.idToken?.tokenString else {
                print("Missing Google ID Token")
                let missingTokenError = NSError(domain: "GoogleSignIn", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing ID Token"])
                completion(.failure(missingTokenError))
                return
            }
            
       
            let email = result.user.profile?.email ?? ""
            let givenName = result.user.profile?.givenName ?? ""
            let familyName = result.user.profile?.familyName ?? ""
            
            print("📧 Email:", email)
            print("👤 Given Name:", givenName)
            print("👪 Family Name:", familyName)
            
            // Authenticate with Firebase
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Auth Error:", error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                
                guard let user = authResult?.user else {
                    print("Firebase User not found")
                    let noUserError = NSError(domain: "FirebaseAuth", code: 1, userInfo: [NSLocalizedDescriptionKey: "Firebase user not found"])
                    completion(.failure(noUserError))
                    return
                }
                
                // Save Firebase UID
                UserDefaultsManager.shared.authToken = user.uid
                print("Signed in with UID:", user.uid)
                
                // Return user details
                completion(.success([
                    "email": email,
                    "givenName": givenName,
                    "familyName": familyName
                ]))
            }
        }
    }

}
