//
//  SignInViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 16/02/2025.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import CryptoKit
import GoogleSignIn

class SignInViewController: UIViewController, UITextViewDelegate,UIGestureRecognizerDelegate{
    
    var social: String = ""
    // make a variable and store the value of view model in the variable
    private var showUserDetailsModel = ShowUserDetailViewModel()
    
    var siginViewModel = SigninViewModel()
    
    @IBOutlet var emailView: UIView!
    @IBOutlet var facebookView: UIView!
    @IBOutlet var appleView: UIView!
    @IBOutlet var googleView: UIView!
    
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var emailPhoneBtn: UIButton!
    
    @IBOutlet var policyTxtView: UITextView!
    
    // MARK: - Properties
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
        configureTextView()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setupView(){
        emailView.layer.cornerRadius = 2
        emailView.layer.borderWidth = 0.6
        emailView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        
        facebookView.layer.cornerRadius = 2
        facebookView.layer.borderWidth = 0.6
        facebookView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        
        appleView.layer.cornerRadius = 2
        appleView.layer.borderWidth = 0.6
        appleView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        
        googleView.layer.cornerRadius = 2
        googleView.layer.borderWidth = 0.6
        googleView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
    }
    
    private func isUserCreated(firstName: String, lastName: String, email: String){
        self.siginViewModel.showUserDetail { result in
            switch result {
            case .success(let status):
                UserDefaultsManager.shared.userId = status.msg?.user?.id?.toString() ?? "0"
                UserDefaultsManager.shared.wallet = status.msg?.user?.wallet ?? "0"
                print("Wallet", UserDefaultsManager.shared.wallet)

                print("User ID", UserDefaultsManager.shared.userId)
                if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                    appdelegate.goToHomeViewController()
                }
            case .failure(let error):
                // account nhi bane hoye
                self.siginViewModel.registerUser(social: self.social, username: "\(firstName + "_" + lastName)", firstName: firstName, lastName: lastName, email: email) { result in
                    switch result {
                    case .success(let status):
                        print("status",status)
                        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                            appdelegate.goToHomeViewController()
                        }
                    case .failure(let error):
                        print("Error : \(error.localizedDescription)")
                        UserDefaultsManager.shared.authToken = ""
                        Utility.shared.showToast(message: "\(error.localizedDescription)")
                 
                    }
                }
            }
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
        
        policyTxtView.attributedText = attributedString
        policyTxtView.textAlignment = .center
        policyTxtView.isEditable = false
        policyTxtView.isSelectable = true
        policyTxtView.isUserInteractionEnabled = true
        policyTxtView.delegate = self
        
        // Ensure links appear black
        policyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    
        policyTxtView.attributedText = attributedString
        policyTxtView.textAlignment = .center
        policyTxtView.isEditable = false
        policyTxtView.isSelectable = true
        policyTxtView.isUserInteractionEnabled = true
        policyTxtView.delegate = self
        
        // Ensure links appear black
        policyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
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

    private func goToSignUpViewController(){
        let vc = DateOfBirthViewController(nibName: "DateOfBirthViewController", bundle: nil)
        vc.social = social
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func emailBtnPressed(_ sender: UIButton) {
        let vc = SignInWithEmailAndPhone(nibName: "SignInWithEmailAndPhone", bundle: nil)
        vc.isSignIn = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func facebookBtnPresed(_ sender: UIButton) {
        print("phone btn facebook")
    }
    
    @IBAction func appleBtnPressed(_ sender: UIButton) {
        social = "apple"
        startSignInWithAppleFlow()
    }
    
    @IBAction func googleBtnPressed(_ sender: UIButton) {
        
        social = "google"
    
        siginViewModel.signinWithGoogle(from: self) { result in
             switch result {
             case .success(let userInfo):
                 self.isUserCreated(firstName: userInfo["givenName"] ?? "", lastName: userInfo["familyName"] ?? "", email: userInfo["email"] ?? "")
             case .failure(let error):
                print("error",error)
                 Utility.shared.showToast(message: error.localizedDescription)
            
            }
        }
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        self.goToSignUpViewController()
    }
    
}

@available(iOS 13, *)
extension SignInViewController: ASAuthorizationControllerDelegate {
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
            
            siginViewModel.signinWithApple(idTokenString: idTokenString, nonce: nonce) { result in
                 switch result {
                 case .success(let status):
                     UserDefaultsManager.shared.userId = status.msg?.user?.id?.toString() ?? "0"
                     
                     if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                         appdelegate.goToHomeViewController()
                     }
                      
                 case .failure(let error):
                     print("Error : \(error.localizedDescription)")
                     let username = Utility.shared.generateRandomUsername()
                     let name = Utility.shared.splitUsername(username)

                     self.siginViewModel.registerUser(social: self.social, username: username, firstName: name.firstName, lastName: name.lastName) { result in
                         switch result {
                         case .success(let status):
                             print("status",status)
                             if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                                 appdelegate.goToHomeViewController()
                             }
                         case .failure(let error):
                             print("Error : \(error.localizedDescription)")
                             UserDefaultsManager.shared.authToken = ""
                             Utility.shared.showToast(message: "\(error.localizedDescription)")
                      
                         }
                     }
                
                }
            }
            
       }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// MARK: - UITextViewDelegate for Link Handling
extension SignInViewController {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}

