//
//  SignUpViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 14/02/2025.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import CryptoKit
import GoogleSignIn

class SignUpViewController: UIViewController, UITextViewDelegate {
    
    
    // make a variable and store the value of view model in the variable
    private var showUserDetailsModel = ShowUserDetailViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet var profileView: UIView!
    @IBOutlet var facebookView: UIView!
    @IBOutlet var appleView: UIView!
    @IBOutlet var googleView: UIView!
    
    @IBOutlet var phoneButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var appleButton: UIButton!
    @IBOutlet var googleButton: UIButton!
    
    @IBOutlet var privacyTxtView: UITextView!
    
    // MARK: - Properties
    fileprivate var currentNonce: String?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTextView()
    }
    
    // MARK: - UI Configuration
    private func configureViews() {
        let views = [profileView, facebookView, appleView, googleView]
        views.forEach { view in
            view?.layer.cornerRadius = 2
            view?.layer.borderWidth = 0.6
            view?.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        }
    }
    
    
    func configureTextView() {
        let message = "By tapping “Continue”, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use, and share your data."
        
        let links: [String: String] = [
            "Terms of Service": "https://www.google.com",
            "Privacy Policy": "https://www.apple.com"
        ]
        
        let attributedString = NSMutableAttributedString(string: message, attributes: [
            .foregroundColor: UIColor(named: "darkTxtGrey") ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        
        for (word, url) in links {
            if let linkRange = message.range(of: word) {
                let nsRange = NSRange(linkRange, in: message)
                attributedString.addAttributes([
                    .link: url
                ], range: nsRange)
            }
        }
        
        privacyTxtView.attributedText = attributedString
        privacyTxtView.textAlignment = .center
        privacyTxtView.isEditable = false
        privacyTxtView.isSelectable = true
        privacyTxtView.isUserInteractionEnabled = true
        privacyTxtView.delegate = self
        
        // Ensure links appear black
        privacyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        
        privacyTxtView.attributedText = attributedString
        privacyTxtView.textAlignment = .center
        privacyTxtView.isEditable = false
        privacyTxtView.isSelectable = true
        privacyTxtView.isUserInteractionEnabled = true
        privacyTxtView.delegate = self
        
        // Ensure links appear black
        privacyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    }
    
    
    // MARK: - Button Actions
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func phoneBtnPressed(_ sender: UIButton) {
        print("Phone button pressed")
    }
    
    @IBAction func facebookBtnPressed(_ sender: UIButton) {
        print("Facebook button pressed")
    }
    
    @IBAction func appleBtnPressed(_ sender: UIButton) {
        startSignInWithAppleFlow()
    }
    
    
    
    
    @IBAction func googleBtnPressed(_ sender: UIButton) {
        guard let presentingViewController = self as? UIViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error = error {
                print("Google Sign-In Error: \(error.localizedDescription)")
                return
            }
            
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            
            guard let idToken = user.idToken?.tokenString else {
                print("Error: Google ID Token missing")
                return
            }
            
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            // 🔥 Sign in with Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Auth Error: \(error.localizedDescription)")
                    return
                }
                
                guard let firebaseUser = authResult?.user else { return }
                
                let email = firebaseUser.email ?? "No Email"
                let name = firebaseUser.displayName ?? "No Name"
                let profilePicUrl = firebaseUser.photoURL?.absoluteString ?? "No Profile Pic"
                
                print("🔥 Firebase User Signed In!")
                print("Name: \(name), Email: \(email), Profile Pic: \(profilePicUrl)")
                
                DispatchQueue.main.async {
                    self.googleButton.isHidden = true
                }
            }
        }
    }
    
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Apple Authentication
private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 { return }
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    return result
}

@available(iOS 13, *)
private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    return hashedData.map { String(format: "%02x", $0) }.joined()
}

@available(iOS 13, *)
extension SignUpViewController: ASAuthorizationControllerDelegate {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to fetch identity token")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = authResult?.user else { return }
                //                UserDefaults.standard.set("AuthToken", forKey: "zLIc8WDIncbUa3QQZPT04gVWZrf1")
                
                // MVVM Implementation , add view model here and access the view model function
                self.showUserDetailsModel.fetchUserDetails()
                
                self.showUserDetailsModel.onShowUserDetailsLoaded = { isLoaded,code in
                    if isLoaded {
                        print("data fetch")
                        if code == 200 {
                            print("User already exist go to login screen")
                            
                        }else {
                            print("User does not exist and show call the register api")
                            let param: [String : Any] =
                            [
                                "dob": "",
                                "username": "wasiqtayyabmehmooodiosdev",
                                "first_name": "tas",
                                "last_name": "as",
                                "email": "",
                                "phone": "",
                                "social_id": "",
                                "auth_token": "EtnpZg9zoWd1qRVTHAZvirR79lF2",
                                "device_token": "fnYqrcmDqkcvtPLfvTxNw6:APA91bG1po76fAKdghUavOh-vikn8tSZbrmpwSihroGc96ebd0jtJtDd005CKeMEjJAGJ9Y78g5-sofl2K1pyKSELs2-f9GlAangLWhUFUMoWkD8rC2BDhg",
                                "social": "apple"
                            ]
                            self.showUserDetailsModel.registerUser(parameters: param)
                        }
                    }else {
                        print("error")
                    }
                }
                
                self.showUserDetailsModel.onRegisterUserLoaded = { isLoaded in
                    if isLoaded {
                        print("showUserDetailsModel",self.showUserDetailsModel.showRegisterUser?.msg)
                    }
                    
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
}

extension SignUpViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// MARK: - UITextViewDelegate for Link Handling
extension SignUpViewController {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
