//
//  SignInWithEmailAndPhone.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 16/02/2025.
//

import UIKit
import PhoneNumberKit

class SignInWithEmailAndPhone: UIViewController, UITextViewDelegate {
    
    var signInLbl = [["isSelected":"true","lbl":"Phone"],["isSelected": "false","lbl":"Email"]]
    var isSignIn = false
    var dateOfBirth: String = ""
    
    var signinEmailPhoneViewModel = SigninEmailPhoneViewModel()
    var social: String = "phone"
    
    private var dialCode = "+92"
    private var defaultRegion = "PK"
    private let phoneNumberKit = PhoneNumberKit()
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var signInCollectionView: UICollectionView!
    @IBOutlet var learnTextView: UITextView!
    
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var emailTextView: UITextView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet var phoneNumberView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet weak var tfPhoneNumber: PhoneNumberTextField!
    
    var siginViewModel = SigninViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPhoneNumber.isPartialFormatterEnabled = true
        tfPhoneNumber.withExamplePlaceholder = true
        tfPhoneNumber.withPrefix = false
        tfPhoneNumber.defaultRegion = self.defaultRegion
        tfPhoneNumber.placeholder = phoneNumberKit.metadata(for: defaultRegion)?.mobile?.exampleNumber
        
        if isSignIn {
            navigationBar.topItem?.title = "Sign In"
            self.emailTextView.isHidden = true
            self.learnTextView.isHidden = true
            self.passwordTextField.isHidden = false
            self.btnForgotPassword.isHidden = false
            
        }else {
            navigationBar.topItem?.title = "Sign Up"
            self.emailTextView.isHidden = false
            self.learnTextView.isHidden = false
        }
        
        setupNavigationBar()
        configureTextView()
        configureEmailTextView()
        configureTextFields()
        addLeftPadding(to: emailTxtField)
        addLeftPadding(to: passwordTextField)
        
        phoneNumberView.isHidden = false
        emailView.isHidden = true
        setupCollectionView()
    }

    func setupNavigationBar(){
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
    }
    
    func configureTextFields(){
        emailTxtField.layer.cornerRadius = 8
        emailTxtField.backgroundColor = UIColor(named: "lightGrey")
        
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.backgroundColor = UIColor(named: "lightGrey")
    }
    func addLeftPadding(to textField: UITextField, width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }


    func configureTextView() {
        let message = """
        Your phone number will be used to improve your LoopLyfe experience, including connecting you with people you may know, personalizing your ads experience, and more. If you sign up with SMS, SMS fees may apply. Learn more
        """
        
        let links = [
            "Learn more": "https://www.google.com"
        ]
        
        let attributedString = NSMutableAttributedString(string: message, attributes: [
            .foregroundColor: UIColor(named: "darkTxtGrey") ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        for (word, url) in links {
            if let linkRange = message.range(of: word) {
                let nsRange = NSRange(linkRange, in: message)
                attributedString.addAttribute(.link, value: url, range: nsRange)
            }
        }
        
        learnTextView.attributedText = attributedString
        learnTextView.textAlignment = .left
        learnTextView.isEditable = false
        learnTextView.isSelectable = true
        learnTextView.isUserInteractionEnabled = true
        learnTextView.dataDetectorTypes = .link
        learnTextView.delegate = self
        
        learnTextView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    
    func configureEmailTextView() {
        let message = """
        Your phone number will be used to improve your LoopLyfe experience, including connecting you with people you may know, personalizing your ads experience, and more. If you sign up with SMS, SMS fees may apply. Learn more
        """
        
        let links = [
            "Learn more": "https://www.google.com"
        ]
        
        let attributedString = NSMutableAttributedString(string: message, attributes: [
            .foregroundColor: UIColor(named: "darkTxtGrey") ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        for (word, url) in links {
            if let linkRange = message.range(of: word) {
                let nsRange = NSRange(linkRange, in: message)
                attributedString.addAttribute(.link, value: url, range: nsRange)
            }
        }
        
        emailTextView.attributedText = attributedString
        emailTextView.textAlignment = .left
        emailTextView.isEditable = false
        emailTextView.isSelectable = true
        emailTextView.isUserInteractionEnabled = true
        emailTextView.dataDetectorTypes = .link
        emailTextView.delegate = self
        
        emailTextView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
  
    func setupCollectionView(){
        signInCollectionView.delegate = self
        signInCollectionView.dataSource = self
        signInCollectionView.register(UINib(nibName: "SignInCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SignInCollectionViewCell")
    }
    
    
    private func sendOTPCode(phone: String){
        signinEmailPhoneViewModel.sendOTP(phone: phone) { result in
            switch result {
            case .success(let verificationId):
                self.goToOTP(phone: phone, verificationId: verificationId)
            case .failure(let error):
                Utility.shared.showToast(message: error.localizedDescription)
            }
        }
    }
    
    private func goToOTP(phone: String, verificationId: String){
        let vc = OTPVerificationViewController(nibName: "OTPVerificationViewController", bundle: nil)
        vc.verificationId = verificationId
        vc.isSignIn = self.isSignIn
        vc.phoneNumber = phone
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectPhoneNumberBtnPressed(_ sender: UIButton) {
        print("Select Country Code")
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        let vc = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func sendCodeOnPhoneTapped(_ sender: UIButton) {
        let phoneNumber = tfPhoneNumber.text!.replacingOccurrences(of: " ", with: "")
        let formattedNumber = dialCode + phoneNumber
        print("formattedNumber",formattedNumber)
        
        guard Utility.isValidPhoneNumber(formattedNumber, region: defaultRegion) else {
            Utility.shared.showToast(message: "Enter the valid phone number")
            return
        }
        
        
        if isSignIn == true {
            self.sendOTPCode(phone: formattedNumber)
        } else {
            let vc = CreateUserNameViewController(nibName: "CreateUserNameViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    @IBAction func sendCodeOneEmailTapped(_ sender: UIButton) {
        guard let email = emailTxtField.text, signinEmailPhoneViewModel.validateEmail(email) else {
            return
        }
    
        if isSignIn == true {
            guard let password = passwordTextField.text, password.count > 8 else {
                Utility.shared.showToast(message: "Password must be greater than 8.")
                return
            }
            self.signIn(email: email, password: password)
        } else {
            signinEmailPhoneViewModel.checkEmail(email: email) { result in
                switch result {
                case .success(let status):
                    let vc = CreatePasswordViewController(nibName: "CreatePasswordViewController", bundle: nil)
                    vc.social = self.social
                    vc.dateOfBirth = self.dateOfBirth
                    vc.email = email
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                case .failure(let error):
                    Utility.shared.showToast(message: error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Collection View Setup
extension SignInWithEmailAndPhone : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signInLbl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignInCollectionViewCell", for: indexPath) as! SignInCollectionViewCell
        cell.signInLbl.text = signInLbl[indexPath.row]["lbl"]
        
        if signInLbl[indexPath.row]["isSelected"] == "true" {
            cell.labelView.isHidden = false
        }else {
            cell.labelView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<signInLbl.count {
            signInLbl[i]["isSelected"] = "false"
        }
        
        signInLbl[indexPath.row]["isSelected"] = "true"
        
        if signInLbl[indexPath.row]["lbl"] == "Email" {
            social = "email"
        } else {
            social = "phone"
        }
        
        print("Social : \(social)")
        
        if indexPath.item == 0 {
            phoneNumberView.isHidden = false
            emailView.isHidden = true
        } else if indexPath.item == 1 {
            phoneNumberView.isHidden = true
            emailView.isHidden = false
        }
        collectionView.reloadData()
    }
}

// MARK: - FUNCTIONS
extension SignInWithEmailAndPhone {
    // sign in flow with email and password
    private func signIn(email: String, password: String) {
        signinEmailPhoneViewModel.signinUser(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                UserDefaultsManager.shared.authToken = authResult.user.uid
                self.siginViewModel.showUserDetail { result in
                    switch result {
                    case .success(let status):
                        UserDefaultsManager.shared.userId = status.msg?.user?.id?.toString() ?? "0"
                        UserDefaultsManager.shared.wallet = status.msg?.user?.wallet ?? "0"
                        print("UserId", UserDefaultsManager.shared.userId)
                        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                            appdelegate.goToHomeViewController()
                        }
                    case .failure(let error):
                        Utility.shared.showToast(message: error.localizedDescription)
                    }
                }
              
            case .failure(let error):
                Utility.shared.showToast(message: error.localizedDescription)
            }
        }
    }
}
